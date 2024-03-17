//
//  MapView.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-09.
//
import SwiftUI
import MapKit


struct MapView: View {
    @ObservedObject var viewModel: JobViewModel
    @State private var selectedJob: Job?
    @State var camera: MapCameraPosition = .automatic
    @Binding var searchText: String
    @State private var timer: Timer? = nil
    @State private var showFilter: Bool = false
    
    @State private var selectedGeoOption: GeoOption?


    @Environment(\.dismiss) var dismiss
    
    
    let defaultPinURL = "https://seeklogo.com/images/M/map-pin-logo-724AC2A023-seeklogo.com.png"
    
    var body: some View {
        Map(position: $camera){
            ForEach(viewModel.jobs) { job in
                Annotation(job.title, coordinate: CLLocationCoordinate2D(latitude: job.latitude, longitude: job.longitude)) {
                    AsyncImage(url: URL(string: job.companyLogo?.absoluteString ?? defaultPinURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    } placeholder: {
                        ProgressView()
                    }.onTapGesture {
                        selectedJob = job
                    }
                }
            }
            
        }.safeAreaInset(edge: .top) {
            HStack {
                ZStack(alignment: .leading) {
                    Color.white
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 15)
                            .foregroundColor(Color(UIColor.systemGray3))
                        
                        
                        TextField("Search here", text: $searchText)
                            .padding(10)
                            .background(Color.clear)
                            .cornerRadius(10)
                            .onChange(of: searchText) { newValue in
                                // Cancel previous timer
                                timer?.invalidate()
                                // Start a new timer to delay API call
                                timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                                    // Perform API call with newValue
                                    viewModel.fetchJobs(tag: newValue, geo: selectedGeoOption?.value ?? "")
                                }
                                
                            }
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 15)
                            .foregroundColor(Color(UIColor.systemGray3)).onTapGesture {
                                self.showFilter = true
                            }
                        
                    }
                }   .padding()
                    .frame(width: 360, height: 46)
                    .padding(.top)
            }
        }
        .sheet(isPresented: $showFilter, onDismiss: {
            print(#function, "dismiss")
            viewModel.fetchJobs(tag: searchText, geo: selectedGeoOption?.value ?? "")
        }, content: {
            FilterView(selectedGeoOption: $selectedGeoOption).presentationDetents([.medium])
        })
        .sheet(item: $selectedJob) { job in
            JobDetailsView(job: job, viewModel: viewModel)
        }
    }
}
