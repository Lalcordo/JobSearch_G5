//
//  JobViewModel.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-09.
import SwiftUI
import Firebase
import FirebaseFirestore

class JobViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    @Published var savedJobs: [Job] = []
    let jobController = JobController(jobService: JobService())
    let db = Firestore.firestore()
    var currentUserID: String?
    
    // Fetch jobs by tag and geo
    func fetchJobs(tag: String, geo: String) {
        print("2nd Time : USER ID is \(currentUserID)")
        jobController.fetchJobs(tag: tag, geo: geo) { [weak self] jobs, error in
            if let jobs = jobs {
                self?.jobs = jobs
            } else if let error = error {
                print(#function, "Cannot fetch jobs: \(error)")
            }
        }
    }
    
    
    func saveJob(_ job: Job) {
        if let userID = currentUserID {
            if !savedJobs.contains(where: { $0.id == job.id }) {
                savedJobs.append(job)
                db.collection("users").document(userID).collection("savedJobs").document(job.id).setData(job.dictionaryRepresentation)
            }
        } else {
            print("Error: Current user ID is nil")
        }
    }
    
    func removeSavedJob(at index: Int) {
        let jobToRemove = savedJobs[index]
        savedJobs.remove(at: index)
        if let userID = currentUserID {
            db.collection("users").document(userID).collection("savedJobs").document(jobToRemove.id).delete()
        } else {
            print("Error: Current user ID is nil")
        }
    }
    
    func retrieveSavedJobs() {
        if let userID = currentUserID {
            db.collection("users").document(userID).collection("savedJobs").getDocuments { [weak self] querySnapshot, error in
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
        } else {
            print("Error: Current user ID is nil")
        }
    }
}
