//
//  HomePage.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-09.
//

import SwiftUI

struct HomePage: View {
    @StateObject var jobViewModel = JobViewModel()
    let industry = "dev" // Example industry

    var body: some View {
        JobView(viewModel: jobViewModel, industry: industry)
    }
}

#Preview {
    HomePage()
}
