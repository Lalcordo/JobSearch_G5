//
//  HomeScreen.swift
//  JobSearch_G5
//
//  Created by Leo Cesar Alcordo on 2024-03-10.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    
    @State private var selectedLink: Int? = 0
    
    var body: some View {
        
        //Navigation Links
        NavigationLink(destination: ProfileView().environmentObject(fireAuthHelper), tag: 1, selection: $selectedLink){}
        NavigationLink(destination: SignInView().environmentObject(fireAuthHelper), tag: 2, selection: $selectedLink){}
        
        
        VStack {
            
            TabView {
                
                SearchJobView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Browse Jobs")
                    }
                
                
                BookmarkedJobsView()
                    .tabItem {
                        Image(systemName: "book")
                        Text("Bookmarked")
                    }
            }
            
        }
        .navigationTitle(Text("Welcome, \(fireAuthHelper.user?.email ?? "User")"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Menu {
                    
                    Button {
                        selectedLink = 1
                    } label: {
                        Text("Profile")
                    }
                    
                    Button{
                        self.fireAuthHelper.signOut()
                        self.signOut()
                    } label: {
                        Text("Logout")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle.fill")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func signOut() {
        selectedLink = 2
    }
}



#Preview {
    HomeScreen()
}
