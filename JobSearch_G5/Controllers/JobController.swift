//
//  JobController.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-09.
//

import Foundation


class JobController {
    var jobService: JobService
    
    init(jobService: JobService) {
        self.jobService = jobService
    }
    
    func fetchJobs(tag: String, geo: String, completion: @escaping ([Job]?, Error?) -> Void) {
        jobService.fetchJobs(tag: tag, geo: geo) { jobs, error in
            if let jobs = jobs {
                DispatchQueue.main.async {
                    completion(jobs, nil)
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
}
