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
    @State private var fnameFromUI: String = ""
    @State private var lnameFromUI: String = ""
    
    
    var body: some View {
        VStack{
            Form {
                Section {
                    TextField ("Enter Email", text: $emailFromUI)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    TextField ("Enter Password", text: $passwordFromUI)
                        .keyboardType(.default)
                        .textInputAutocapitalization(.never)
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
                    Text("Personal Information")
                        .font(.headline)
                }
            }
            
            Button {
                
                if emailFromUI.isEmpty || passwordFromUI.isEmpty || fnameFromUI.isEmpty || lnameFromUI.isEmpty {
                    return
                } else {
                    fireAuthHelper.signUp(email: emailFromUI, password: passwordFromUI, firstName: fnameFromUI, lastName: lnameFromUI)
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
