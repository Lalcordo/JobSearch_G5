//
//  SavedJobsView.swift
//  JobSearch_G5
//
//  Created by Gagan Singh Grewal on 2024-03-13.
//

import SwiftUI

struct SavedJobsView: View {
    @ObservedObject var viewModel: JobViewModel
    @State private var selectedJob: Job?
    @EnvironmentObject var fireAuthHelper : FireAuthHelper

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.savedJobs.indices, id: \.self) { index in
                    let savedJob = viewModel.savedJobs[index]
                    VStack(alignment: .leading) {
                        Text(savedJob.title)
                            .font(.headline)
                        HStack {
                            if let imageURL = savedJob.companyLogo {
                                AsyncImage(url: imageURL) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    @unknown default:
                                        Image(systemName: "building.2.crop.circle")
                                    }
                                }
                            } else {
                                Image(systemName: "building.2.crop.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                            Text(savedJob.company)
                                .font(.subheadline)
                            Spacer()
                        }
                    }
                    .onTapGesture {
                        selectedJob = savedJob
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        viewModel.removeSavedJob(at: index)
                    }
                })
            }
            .navigationBarTitle("Saved Jobs")
            .sheet(item: $selectedJob) { job in
                JobDetailsView(job: job, viewModel: viewModel)
            }.onAppear() {
                viewModel.retrieveSavedJobs()
            }
        }
    }
}

