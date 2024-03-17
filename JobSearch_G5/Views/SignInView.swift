//
//  ContentView.swift
//  JobSearch_G5
//
//  Created by Leo Cesar Alcordo on 2024-03-09.
//
import SwiftUI

struct SignInView: View {
    var fireAuthHelper: FireAuthHelper = FireAuthHelper()
    
    
    @State private var rememberMe = false
    @State private var emailFromUI: String = ""
    @State private var passwordFromUI: String = ""
    
   
    @State private var showAlert: Bool = false
    @State private var alertTitle = ""
    @State private var resultMessage: String = ""
    @State private var alertConfirmation: String = ""
    
    
    @EnvironmentObject var viewModel: JobViewModel
    
    
    @State private var selectedLink: Int? = 0
    @State private var showSignUp = false
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: HomeScreen().environmentObject(fireAuthHelper), tag: 1, selection: $selectedLink){}
                Spacer()
                
                // Logo and title
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200.0, height: 200.0)
                    .padding(.all)
                
                Text("Login")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                // Username Field
                TextField("Email Address", text: $emailFromUI)
                    .padding(.all)
                    .frame(width: 250.0, height: 50.0)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10.0)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                // Password Field
                SecureField("Password", text: $passwordFromUI)
                    .padding(.all)
                    .frame(width: 250.0, height: 50.0)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10.0)
                
                // Remember Me Toggle
                Toggle("Remember Me", isOn: $rememberMe)
                    .padding(.all)
                    .frame(width: 250.0, height: 50.0)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                
                // Login Button
                Button(action: {
                    // Attempt login
                    self.login()
                }) {
                    Text("Login")
                }
                .padding()
                .frame(width: 150.0, height: 50.0)
                .background(Color.blue)
                .foregroundColor(.white)
                .font(.title)
                .cornerRadius(10.0)
                .alert(isPresented: $showAlert){
                    Alert(title: Text("\(alertTitle)"),
                          message: Text("\(resultMessage)"),
                          dismissButton: .default(Text("\(alertConfirmation)")){})
                }
                
                Spacer()
                
                Text("Don't have an Account?")
                    .font(.caption2)
                    .fontWeight(.light)
                    .padding([.top, .leading, .trailing])
                    .italic()
             
                Button(action: {
                    self.showSignUp.toggle()
                }) {
                    Text("Register Here")
                }
                .sheet(isPresented: $showSignUp) {
                    SignUpView(showSignUp: $showSignUp).environmentObject(fireAuthHelper)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .background(Color.white)
            .onAppear {
                if UserDefaults.standard.bool(forKey: "KEY_REMEMBERME") {
                    emailFromUI = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
                    passwordFromUI = UserDefaults.standard.string(forKey: "KEY_PASSWORD") ?? ""
                }
            }
        }
    }
    
  
    private func login() {
        if emailFromUI.isEmpty || passwordFromUI.isEmpty {
            showAlert = true
            alertTitle = "INVALID CREDENTIALS"
            resultMessage = "Fields cannot be empty!"
            alertConfirmation = "CONFIRM"
            return
        } else {
            self.fireAuthHelper.signIn(email: emailFromUI, password: passwordFromUI) { success in
                if success {
                    if rememberMe {
                        UserDefaults.standard.set(rememberMe, forKey: "KEY_REMEMBERME")
                        UserDefaults.standard.set(emailFromUI, forKey: "KEY_EMAIL")
                        UserDefaults.standard.set(passwordFromUI, forKey: "KEY_PASSWORD")
                    } else {
                        UserDefaults.standard.removeObject(forKey: "KEY_REMEMBERME")
                        UserDefaults.standard.removeObject(forKey: "KEY_EMAIL")
                        UserDefaults.standard.removeObject(forKey: "KEY_PASSWORD")
                    }
                    
                    if let userID = self.fireAuthHelper.currentUserID {
                        self.viewModel.currentUserID = self.fireAuthHelper.user?.email
                        print("HERE IS USER ID \(userID)")
                        self.selectedLink = 1 // Set selectedLink to 1 after successful login
                    
                    } else {
                        showAlert = true
                        alertTitle = "USER ID NOT FOUND"
                        resultMessage = "Failed to retrieve user ID"
                        alertConfirmation = "OK"
                    }
                } else {
                    showAlert = true
                    alertTitle = "INVALID CREDENTIALS"
                    resultMessage = "Email or Password is incorrect"
                    alertConfirmation = "TRY AGAIN"
                    return
                }
            }
        }
    }

}
