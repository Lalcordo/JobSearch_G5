//
//  JobService.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-09.
//

import Foundation
import Alamofire
import SwiftyJSON

class JobService {
    func fetchJobs(industry: String, completion: @escaping ([Job]?, Error?) -> Void) {
        let apiURL = "https://jobicy.com/api/v2/remote-jobs?count=20&industry=\(industry)"
        AF.request(apiURL).responseJSON { response in
            switch response.result {
            case .success(let responseData):
                let json = JSON(responseData)
                let jobs = json["jobs"].arrayValue.compactMap { jobJSON in
                    return Job(
                        id: jobJSON["id"].stringValue,
                        title: jobJSON["jobTitle"].stringValue,
                        company: jobJSON["companyName"].stringValue,
                        companyLogo: jobJSON["companyLogo"].url,
                        type: jobJSON["jobType"].arrayValue.first?.stringValue ?? "",
                        description: jobJSON["jobExcerpt"].stringValue
                    )
                }
                print(jobs)
                completion(jobs, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
