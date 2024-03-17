//
//  HomeScreen.swift
//  JobSearch_G5
//
//  Created by Leo Cesar Alcordo on 2024-03-10.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var viewModel : JobViewModel
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    
    @State private var searchText: String = ""
    @State private var displayName: String = ""
    @State private var selectedLink: Int? = 0
    
    var body: some View {
        
        //Navigation Links
        NavigationLink(destination: ProfileView().environmentObject(fireAuthHelper), tag: 1, selection: $selectedLink){}
        NavigationLink(destination: SignInView().environmentObject(fireAuthHelper), tag: 2, selection: $selectedLink){}
        
        
        VStack {
            
            TabView {
                MapView(viewModel: viewModel, searchText: $searchText).tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Browse Jobs")
                }.background(Color.red)
                
                JobView(viewModel: viewModel).tabItem {
                    Image(systemName: "briefcase.fill")
                    Text("Jobs")
                }
                
                SavedJobsView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "book")
                        Text("Bookmarked")
                    }
        
            } .onAppear {
                // Initial retrieval of display name
                if let displayName = fireAuthHelper.user?.displayName {
                    self.displayName = displayName
                }
                
                // Fetch data and set up initial state
                viewModel.retrieveSavedJobs()
                viewModel.fetchJobs(tag: searchText, geo: "")
            }

        }   .navigationTitle(Text("Welcome, \(displayName.isEmpty ? "User" : displayName)"))
            .navigationBarTitleDisplayMode(.inline)
//        .navigationTitle(Text("Welcome, \(self.fireAuthHelper.user?.displayName ?? "User")"))
//        .navigationBarTitleDisplayMode(.inline)
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
