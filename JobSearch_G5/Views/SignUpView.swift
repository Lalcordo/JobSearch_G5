//
//  SignUp.swift
//  JobSearch_G5
//
//  Created by Leo Cesar Alcordo on 2024-03-10.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    
    
    @Binding var showSignUp: Bool
    @State private var emailFromUI: String = ""
    @State private var passwordFromUI: String = ""
    @State private var reenterPasswordFromUI: String = ""
    @State private var fnameFromUI: String = ""
    @State private var lnameFromUI: String = ""
    
    
    @State private var showAlert: Bool = false
    @State private var alertTitle = ""
    @State private var resultMessage: String = ""
    @State private var alertConfirmation: String = ""
    
    
    var body: some View {
        VStack{
            Form {
                Section {
                    TextField ("Enter Email", text: $emailFromUI)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    SecureField ("Enter Password", text: $passwordFromUI)
                        .keyboardType(.default)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    SecureField ("Re-enter Password", text: $reenterPasswordFromUI)
                        .keyboardType(.default)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                } header: {
                    Text("User Credentials")
                        .font(.headline)
                }
                
                Section {
                    TextField ("First Name", text: $fnameFromUI)
                        .keyboardType(.default)
                    
                    TextField ("Last Name", text: $lnameFromUI)
                        .keyboardType(.default)
                    
                } header: {
                    Text("Contact Information")
                        .font(.headline)
                }
            }
            
            Button {
                
                if emailFromUI.isEmpty || passwordFromUI.isEmpty || reenterPasswordFromUI.isEmpty || fnameFromUI.isEmpty || lnameFromUI.isEmpty {
                    
                    showAlert = true
                    alertTitle = "CAUTION!"
                    resultMessage = "Fields cannot be empty."
                    alertConfirmation = "TRY AGAIN"
                    
                    return
                    
                } else if passwordFromUI != reenterPasswordFromUI {
                    showAlert = true
                    alertTitle = "INVALID CREDENTIALS"
                    resultMessage = "Password didn't match."
                    alertConfirmation = "TRY AGAIN"
                    return
                    
                } else {
                    fireAuthHelper.signUp(email: emailFromUI, password: passwordFromUI, firstName: fnameFromUI, lastName: lnameFromUI, completion: { success in
                        
                        if success {
                            showAlert = true
                            alertTitle = "SUCCESS!"
                            resultMessage = "Account created"
                            alertConfirmation = "CONFIRM"
                        } else {
                            showAlert = true
                            alertTitle = "CAUTION"
                            resultMessage = "Account was not successfully created. Check your email or password"
                            alertConfirmation = "OK"
                        }
                        
                    })
                    
                    

                }
                
            } label: {
                Text("REGISTER")
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            .alert(isPresented: $showAlert){
                Alert(title: Text("\(alertTitle)"),
                      message: Text("\(resultMessage)"),
                      dismissButton: .default(Text("\(alertConfirmation)")){
                    if alertConfirmation == "CONFIRM" {
                        showSignUp = false
                    }
                    
                })
            }
            
            Spacer()
        }
    }
}

//#Preview {
//    SignUpView()
//}
