//
//  HomeScreen.swift
//  JobSearch_G5
//
//  Created by Leo Cesar Alcordo on 2024-03-10.
//

import SwiftUI

struct HomeScreen: View {
    
    
    @State private var selectedLink: Int? = 0
    var body: some View {
        
        NavigationLink(destination: ProfileView(), tag: 1, selection: $selectedLink){}
        NavigationLink(destination: SignInView(), tag: 2, selection: $selectedLink){}
        
        
        VStack {
            
            TabView {
                
                SearchJobView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Browse Activities")
                    }
                
                
                BookmarkedJobsView()
                    .tabItem {
                        Image(systemName: "suit.heart.fill")
                        Text("Bookmarked")
                    }
            }
            
        }
        .navigationTitle(Text("Welcome, User"))
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
                        selectedLink = 2
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
}

#Preview {
    HomeScreen()
}
