//
//  JobView.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-09.
//

import SwiftUI


struct JobView: View {
    @ObservedObject var viewModel: JobViewModel
    let industry: String
    var body: some View {
        VStack {
            Text("Jobs in \(industry)")
                .font(.title)
                .padding()
            
            List(viewModel.jobs) { job in
                VStack(alignment: .leading) {
                    Text(job.title)
                        .font(.headline)
                    HStack{
                        if let imageURL = job.companyLogo {
                            AsyncImage(url: imageURL){ phase in
                                switch phase{
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    
                                @unknown default:
                                    Image(systemName: "building.2.crop.circle")
                                }
                            }
                        }
                        
                        Text(job.company)
                            .font(.subheadline)
                    }
                }
            }
            .onAppear {
//                viewModel.fetchJobs(industry: industry)
            }
        }
    }
}

