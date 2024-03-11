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
    @State private var rememberMe = UserDefaults.standard.bool(forKey: "REMEMBER_ME")
    @State private var emailFromUI: String = ""
    @State private var passwordFromUI: String = ""
    @State private var isLoggedIn = false
    
    //Helper Variables
    @State private var selectedLink: Int? = 0
    @State private var showSignUp = false
    
    
    
    var body: some View {
        NavigationStack {
            
            //Navigation Link Views
            NavigationLink(destination: HomeScreen().environmentObject(fireAuthHelper), tag: 1, selection: $selectedLink){}
            
            
            VStack {
                
                Spacer()
                
                Image(systemName: "flag.checkered.2.crossed")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200.0, height: 200.0)
                    .clipShape(Circle())
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
                //                .border(/*@START_MENU_TOKEN@*/Color.red/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/4/*@END_MENU_TOKEN@*/)
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
                    .toggleStyle(SwitchToggleStyle(tint: .red))
                
                //----------------------
                
                //Login Button
                Button {
                    if emailFromUI.isEmpty || passwordFromUI.isEmpty {
                        return
                    } else {
                        
                    //TODO: Authenticate user then go to HomeScreen()
                        self.fireAuthHelper.signIn(email: emailFromUI, password: passwordFromUI)
                        selectedLink = 1
                    }
                } label: {
                    Text("Login")
                    
                }
                .padding()
                .frame(width: 150.0, height: 50.0)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.128, green: 0.262, blue: 0.337)/*@END_MENU_TOKEN@*/)
                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
//                .alert(isPresented: $showAlert){
//                    Alert(title: Text("\(alertTitle)"),
//                          message: Text("\(resultMessage)"),
//                          dismissButton: .default(Text("\(alertConfirmation)")){})
//                }
                //----------------------
                Spacer()
                
                Button {
                    showSignUp = true
                } label: {
                    Text("Create an Account")
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
                
                if rememberMe {
                    emailFromUI = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
                    passwordFromUI = UserDefaults.standard.string(forKey: "KEY_PASSWORD") ?? ""
                }
                
                
                //isLoggedIn conditional
//                if userDefaults.bool(forKey: "ISLOGGEDIN_KEY") {
//                    authenticateUser(email: "\(userDefaults.string(forKey: "USERNAME_KEY") ?? "")", password: "\(userDefaults.string(forKey: "PASSWORD_KEY") ?? "")")
//                }
            }
            
        }
        .padding()
    }
}

#Preview {
    SignInView()
}
