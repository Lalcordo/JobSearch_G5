//
//  JobService.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-09.
//

import Foundation
import Alamofire
import SwiftyJSON
import MapKit


class JobService {
    func fetchJobs(tag: String, completion: @escaping ([Job]?, Error?) -> Void) {
        let apiURL = "https://jobicy.com/api/v2/remote-jobs?count=20" + (tag.isEmpty ? "" : "&tag=\(tag)")
        
        AF.request(apiURL).responseJSON { response in
            switch response.result {
            case .success(let responseData):
                let json = JSON(responseData)
                let jobJSONs = json["jobs"].arrayValue
                
                var jobs = [Job]()
                let dispatchGroup = DispatchGroup()
                
                for jobJSON in jobJSONs {
                    dispatchGroup.enter()
                    
                    let searchRequest = MKLocalSearch.Request()
                    searchRequest.naturalLanguageQuery = jobJSON["companyName"].stringValue
                    
                    let search = MKLocalSearch(request: searchRequest)
                    search.start { (response, error) in
                        defer {
                            dispatchGroup.leave()
                        }
                        
                        guard let mapItems = response?.mapItems, let firstItem = mapItems.first else {
                            print("Error: \(error?.localizedDescription ?? "Unknown error")")
                            return
                        }
                        
                        let coordinate = firstItem.placemark.coordinate
                        let job = Job(
                            id: jobJSON["id"].stringValue,
                            title: jobJSON["jobTitle"].stringValue,
                            company: jobJSON["companyName"].stringValue,
                            companyLogo: jobJSON["companyLogo"].url,
                            type: jobJSON["jobType"].arrayValue.first?.stringValue ?? "",
                            description: jobJSON["jobExcerpt"].stringValue,
                            latitude: coordinate.latitude,
                            longitude: coordinate.longitude
                        )
                        jobs.append(job)
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    completion(jobs, nil)
                }
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

