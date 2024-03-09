//
//  JobViewModel.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-09.
//

import Foundation

class JobViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    let jobController = JobController(jobService: JobService())
    
    func fetchJobs(industry: String) {
        
        jobController.fetchJobs(industry: industry) { jobs, error in
            if let jobs = jobs {
                // Handle fetched jobs
                self.jobs = jobs
            } else if let error = error {
                // Handle error
                print(#function, "Cannot fetch jobs: \(error)")
            }
        }
    }
}
