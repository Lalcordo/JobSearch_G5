//
//  FireAuthHelper.swift
//  JobSearch_G5
//
//  Created by Leo Cesar Alcordo on 2024-03-10.
//

import Foundation
import FirebaseAuth

class FireAuthHelper: ObservableObject {
    
    //User logged in
    @Published var user: User?
    
    func listenToAuthState() {
        
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            
            //create user through firebase, else do not continue and print error
            guard let result = authResult else {
                print(#function, "Error while creating account: \(error)")
                return
            }
            
            print(#function, "AuthResult: \(result.user)")
            
            
            switch authResult {
            case .none:
                print(#function, "Unable to create the account")
            case .some(_):
                print(#function, "Successfully created user account")
                self.user = authResult?.user
                
                
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
            }
            
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { [self] authResult, error in
            
            guard let result = authResult else {
                print(#function, "Error while logging in: \(error)")
                return
            }
            
            print(#function, "AuthResult: \(result.user)")
            
            
            switch authResult {
            case .none:
                print(#function, "Unable to sign in")
            case .some(_):
                print(#function, "Login Successful")
                self.user = authResult?.user
                
                print(#function, "Logged in user: \(self.user?.displayName)")
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
            }
            
        })
    }
    
    func signOut() {
        
    }
}
