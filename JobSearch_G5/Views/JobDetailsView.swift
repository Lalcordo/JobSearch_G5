//
//  JobDetailsView.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-13.
//

import SwiftUI


struct JobDetailsView: View {
    let job: Job
    @ObservedObject var viewModel: JobViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(job.title)
                    .font(.headline)
                Spacer()
                Button(action: {
                    viewModel.saveJob(job)
                }) {
                    if viewModel.savedJobs.contains(where: { $0.id == job.id }) {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(.blue)
                    } else {
                        Image(systemName: "bookmark")
                            .foregroundColor(.blue)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.bottom)
         
               
            if let imageURL = job.companyLogo {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    @unknown default:
                        Image(systemName: "building.2.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                }
            } else {
                Image(systemName: "building.2.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
            Text(job.company)
                .font(.subheadline)
                .padding(.bottom)
            Text(job.description)
                .font(.body)
                .padding(.bottom)
            Spacer()
        }
        .padding()
        .navigationBarTitle("Job Details")
    }
}

