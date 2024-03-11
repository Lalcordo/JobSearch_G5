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
    
    
    var body: some View {
        VStack{
            Form {
                Section {
                    TextField ("Enter Email", text: $emailFromUI)
                    TextField ("Enter Password", text: $passwordFromUI)
                } header: {
                    Text("User Credentials")
                        .font(.headline)
                }
                
                Section {
                    
                } header: {
                    Text("Personal Information")
                        .font(.headline)
                }
            }
            
            Button {
                
            //TODO: MAke an account function
                if emailFromUI.isEmpty || passwordFromUI.isEmpty {
                    return
                } else {
                    fireAuthHelper.signUp(email: emailFromUI, password: passwordFromUI)
                    showSignUp = false
                }
                
            } label: {
                Text("REGISTER")
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            
            Spacer()
        }
    }
}

//#Preview {
//    SignUpView()
//}
