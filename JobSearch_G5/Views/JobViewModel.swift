//
//  JobViewModel.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-09.
//

import Foundation
import Firebase
import FirebaseFirestore

class JobViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    @Published var savedJobs: [Job] = []
    let jobController = JobController(jobService: JobService())
    let db = Firestore.firestore()
    
    func fetchJobs(tag: String, geo: String) {
        
        jobController.fetchJobs(tag: tag, geo: geo) { jobs, error in
            if let jobs = jobs {
                // Handle fetched jobs
                print(#function, jobs)
                self.jobs = jobs
            } else if let error = error {
                // Handle error
                print(#function, "Cannot fetch jobs: \(error)")
            }
        }
    }
    
    func saveJob(_ job: Job) {
        if !savedJobs.contains(where: { $0.id == job.id }) {
            savedJobs.append(job)
            db.collection("savedJobs").document(job.id).setData(job.dictionaryRepresentation)
        }
    }
    
    func removeSavedJob(at index: Int) {
        let jobToRemove = savedJobs[index]
        savedJobs.remove(at: index)
        db.collection("savedJobs").document(jobToRemove.id).delete()
    }
    

    func retrieveSavedJobs() {
        db.collection("savedJobs").getDocuments { [weak self] querySnapshot, error in
            if let error = error {
                print("Error retrieving saved jobs: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else { return }
                let savedJobs = documents.compactMap { queryDocumentSnapshot -> Job? in
                    let data = queryDocumentSnapshot.data()
                    let job = Job(id: queryDocumentSnapshot.documentID,
                                  title: data["title"] as? String ?? "",
                                  company: data["company"] as? String ?? "",
                                  companyLogo: URL(string: data["companyLogo"] as? String ?? ""),
                                  type: data["type"] as? String ?? "",
                                  description: data["description"] as? String ?? "",
                                  latitude: data["latitude"] as? Double ?? 0.0,
                                  longitude: data["longitude"] as? Double ?? 0.0
                    )
                    return job
                }
                DispatchQueue.main.async {
                    self?.savedJobs = savedJobs
                }
            }
        }
    }
    
}
