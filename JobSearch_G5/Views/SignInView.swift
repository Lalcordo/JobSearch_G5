//
//  ContentView.swift
//  JobSearch_G5
//
//  Created by Leo Cesar Alcordo on 2024-03-09.
//

import SwiftUI

struct SignInView: View {
    
    var fireAuthHelper: FireAuthHelper = FireAuthHelper()
    
    //UI variables
    @State private var rememberMe = false
    @State private var emailFromUI: String = "leo@email.com"
    @State private var passwordFromUI: String = "123456"
    
    //Helper Variables
    @State private var selectedLink: Int? = 0
    @State private var showSignUp = false
    
    //Show Alert variables
    @State private var showAlert: Bool = false
    @State private var alertTitle = ""
    @State private var resultMessage: String = ""
    @State private var alertConfirmation: String = ""
    
    
    
    var body: some View {
        NavigationStack {
            
            //Navigation Link Views
            NavigationLink(destination: HomeScreen().environmentObject(fireAuthHelper), tag: 1, selection: $selectedLink){}
            
            
            VStack {
                
                
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200.0, height: 200.0)
//                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 0)
                    )
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                //Title
                Text("Login")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                //----------------------
                
                //Username Field
                TextField("Email Address", text: $emailFromUI)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .frame(width: 250.0, height: 50.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.159)/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                //----------------------
                
                //Password Field
                SecureField("Password", text: $passwordFromUI)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .frame(width: 250.0, height: 50.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.159)/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .keyboardType(.default)
                    .cornerRadius(/*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                //----------------------
                
                //Remember Me Toggle
                Toggle("Remember Me", isOn: $rememberMe)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .frame(width: 250.0, height: 50.0)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                
                //----------------------
                
                //Login Button
                Button {
                    
                    if emailFromUI.isEmpty || passwordFromUI.isEmpty {
                        showAlert = true
                        alertTitle = "INVALID CREDENTIALS"
                        resultMessage = "Fields cannot be empty!"
                        alertConfirmation = "CONFIRM"
                        return
                    } else {
                        self.fireAuthHelper.signIn(email: emailFromUI, password: passwordFromUI, completion: {success in
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
                                selectedLink = 1
                            } else {
                                showAlert = true
                                alertTitle = "INVALID CREDENTIALS"
                                resultMessage = "Email or Password is incorrect"
                                alertConfirmation = "TRY AGAIN"
                                return
                            }
                        })
                    }
                } label: {
                    Text("Login")
                    
                }
                .padding()
                .frame(width: 150.0, height: 50.0)
                .background(.blue)
                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                .alert(isPresented: $showAlert){
                    Alert(title: Text("\(alertTitle)"),
                          message: Text("\(resultMessage)"),
                          dismissButton: .default(Text("\(alertConfirmation)")){})
                }
                //----------------------
                Spacer()
                
                Text("Don't have an Account?")
                    .font(.caption2)
                    .fontWeight(.light)
                    .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing]/*@END_MENU_TOKEN@*/)
                    .italic()
                //SignUP Button
                Button {
                    showSignUp = true
                } label: {
                    Text("Register Here")
                }
                .sheet(isPresented: self.$showSignUp, content: {
                    SignUpView(showSignUp: $showSignUp).environmentObject(fireAuthHelper)
                })
                Spacer()
                
            }
            .padding()
            .navigationBarHidden(true)
            .background(Color.white)
            .onAppear{
                
                if UserDefaults.standard.bool(forKey: "KEY_REMEMBERME") {
                    emailFromUI = UserDefaults.standard.string(forKey: "KEY_EMAIL")!
                    passwordFromUI = UserDefaults.standard.string(forKey: "KEY_PASSWORD")!
                }
            }
            
            
        }
        .padding()
    }
}

#Preview {
    SignInView()
}
