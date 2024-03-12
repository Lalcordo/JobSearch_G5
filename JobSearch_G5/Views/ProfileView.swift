//
//  ProfileView.swift
//  JobSearch_G5
//
//  Created by Leo Cesar Alcordo on 2024-03-10.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    
    var body: some View {
        Text("Welcome, \(fireAuthHelper.user?.email ?? "User")")
        Text("Welcome, \(fireAuthHelper.user?.displayName ?? "")")
    }
}

#Preview {
    ProfileView()
}
