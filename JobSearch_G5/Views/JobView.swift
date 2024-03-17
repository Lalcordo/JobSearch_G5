import SwiftUI
struct JobView: View {
    @ObservedObject var viewModel: JobViewModel
    var body: some View {
        NavigationView {
            VStack {
                Text("Jobs")
                    .font(.title)
                    .padding()
                List(viewModel.jobs) { job in
                    NavigationLink(destination: JobDetailsView(job: job, viewModel: viewModel)) {
                        VStack(alignment: .leading) {
                            Text(job.title)
                                .font(.headline)
                            HStack {
                                if let imageURL = job.companyLogo {
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
                                }
                                Text(job.company)
                                    .font(.subheadline)
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
                        }
                    }
                }
            }
        }
    }
}
