//
//  Job.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-09.
//

import Foundation

struct Job : Codable, Identifiable{
    let id : String
    let title : String
    let company : String
    let companyLogo : URL?
    let type : String?
    let description : String
    let latitude: Double
    let longitude: Double
    
    var dictionaryRepresentation: [String: Any] {
        [
            "id": id,
            "title": title,
            "company": company,
            "companyLogo": companyLogo?.absoluteString ?? "", // URL to string
            "type": type ?? "",
            "description": description
        ]
    }
    
}

