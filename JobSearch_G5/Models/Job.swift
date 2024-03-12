//
//  Job.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-09.
//

import Foundation

struct Job : Identifiable{
    let id : String
    let title : String
    let company : String
    let companyLogo : URL?
    let type : String?
    let description : String
}

