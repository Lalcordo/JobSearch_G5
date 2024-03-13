//
//  JobSearch_G5App.swift
//  JobSearch_G5
//
//  Created by Leo Cesar Alcordo on 2024-03-09.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth
import FirebaseFirestore



@main
struct JobSearch_G5App: App {
    
    //need to add this for initializing Firebase
    init() {
        FirebaseApp.configure()
    }
    let jobController = JobController(jobService: JobService())
    var body: some Scene {
        WindowGroup {
            SignInView()
            
        }
    }
}
