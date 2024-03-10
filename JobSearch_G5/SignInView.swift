//
//  ContentView.swift
//  JobSearch_G5
//
//  Created by Leo Cesar Alcordo on 2024-03-09.
//

import SwiftUI

struct SignInView: View {
    
    //UI variables
    @State private var rememberMe = UserDefaults.standard.bool(forKey: "REMEMBER_ME")
    @State private var userNameFromUI: String = ""
    @State private var passwordFromUI: String = ""
    @State private var isLoggedIn = false
    
    //Helper Variables
    @State private var selectedLink: Int? = 0
    
    
    
    var body: some View {
        NavigationStack {
            
            //Navigation Link Views
            NavigationLink(destination: HomeScreen(), tag: 1, selection: $selectedLink){}
            NavigationLink(destination: SignUp(), tag: 2, selection: $selectedLink){}
            
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
                TextField("Email Address", text: $userNameFromUI)
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
//                    authenticateUser(email: userNameFromUI, password: passwordFromUI)
                    selectedLink = 1
                    print("\(userNameFromUI) \(passwordFromUI) \(rememberMe)")
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
                    selectedLink = 2
                } label: {
                    Text("Sign up")
                }
                Spacer()
                
            }
            .padding()
            .navigationBarHidden(true)
            .background(Color.white)
            .onAppear{
//                checkLoginStatus()
                
                
                //Remember me conditional
                if UserDefaults.standard.bool(forKey: "REMEMBER_ME") {
                    userNameFromUI = UserDefaults.standard.string(forKey: "REMEMBER_USERNAME_KEY")!
                    passwordFromUI = UserDefaults.standard.string(forKey: "REMEMBER_PASSWORD_KEY")!
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
