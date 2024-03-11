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
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                //no change in the auth state
                return
            }
            
            //user's auth state ahs changed
            self.user = user
        }
    }
    
    func signUp(email: String, password: String, firstName: String, lastName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            
            //create user through firebase, else do not continue and print error
            guard let result = authResult else {
                print(#function, "Error while creating account: \(error!)")
                return
            }
            
            print(#function, "AuthResult: \(result.user)")
            
            
            switch authResult {
            case .none:
                print(#function, "Unable to create the account")
            case .some(_):
                print(#function, "Successfully created user account")
                self.user = authResult?.user
                
                self.updateProfile(firstName: firstName, lastName: lastName)
                
            }
            
        }
    }
    
    //the parameter, completion:, outputs as boolean, and will wait for the response once it runs. This is good to use for getting data from a network that has a delay.
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { [self] authResult, error in
            guard let result = authResult else {
                completion(false)
                print(#function, "Error while logging in: \(error!)")
                return
            }
            
            print(#function, "AuthResult: \(result.user)")
            
            
            switch authResult {
            case .none:
                print(#function, "Unable to sign in")
            case .some(_):
                print(#function, "Login Successful")
                self.user = authResult?.user
//                print(#function, "Logged in user: \(self.user?.email!)")
                completion(true)
                print(completion)
            }
            
        })
    }
    
    func signOut() {
        
        do{
            try Auth.auth().signOut()
        } catch let err as NSError {
            print(#function, "Unable to sign out the user: \(err)")
        }
    }
    
    func updateProfile(firstName: String, lastName: String) {
        let changeRequest = self.user?.createProfileChangeRequest()
        
        changeRequest?.displayName = "\(firstName) \(lastName)"
        
        changeRequest?.commitChanges(completion: { error in
            if let error = error {
                print("Error setting display name: \(error.localizedDescription)")
                return
            }
            print("Display name set successfully")
        })
    }
}
