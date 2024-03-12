//
//  MapView.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-09.
//
import SwiftUI
import MapKit

struct MapView: View {
    @State private var annotations: [MKPointAnnotation] = []
    
    var body: some View {
        MyMap(annotations: annotations)
            .onAppear {
                addAnnotations()
            }
    }
    
    func addAnnotations() {
        let yorkvilleAnnotation = MKPointAnnotation()
        yorkvilleAnnotation.coordinate = CLLocationCoordinate2D(latitude: 43.6708, longitude: -79.3935)
        yorkvilleAnnotation.title = "Software Engineer"
        yorkvilleAnnotation.subtitle = "yorkvilleImage"
        
        let churchAndWellesleyAnnotation = MKPointAnnotation()
        churchAndWellesleyAnnotation.coordinate = CLLocationCoordinate2D(latitude: 43.6657, longitude: -79.3804)
        churchAndWellesleyAnnotation.title = "Software Developer"
                churchAndWellesleyAnnotation.subtitle = "churchAndWellesleyImage"
        
//        let romAnnotation = MKPointAnnotation()
//               romAnnotation.coordinate = CLLocationCoordinate2D(latitude: 36.632570, longitude: -82.142170)
//               romAnnotation.title = "asdasdasda"
//        romAnnotation.subtitle = "asdasdasda"

               
        annotations.append(yorkvilleAnnotation)
        annotations.append(churchAndWellesleyAnnotation)
//        annotations.append(romAnnotation) // Add ROM annotation

    }
}

struct MyMap: UIViewRepresentable {
    typealias UIViewType = MKMapView
    var annotations: [MKPointAnnotation]
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView(frame: .zero)
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isUserInteractionEnabled = true
        map.showsUserLocation = true
//        map.delegate = context.coordinator // Set delegate to handle annotation view customization
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations) // Clear existing annotations
        
        // Add new annotations
        for annotation in annotations {
            uiView.addAnnotation(annotation)
        }
        
        //         Adjust the visible region of the map to fit all annotations
        if let firstAnnotation = annotations.first {
            var minLat = firstAnnotation.coordinate.latitude
            var maxLat = firstAnnotation.coordinate.latitude
            var minLon = firstAnnotation.coordinate.longitude
            var maxLon = firstAnnotation.coordinate.longitude
            
            for annotation in annotations {
                minLat = min(minLat, annotation.coordinate.latitude)
                maxLat = max(maxLat, annotation.coordinate.latitude)
                minLon = min(minLon, annotation.coordinate.longitude)
                maxLon = max(maxLon, annotation.coordinate.longitude)
            }
            
            let span = MKCoordinateSpan(latitudeDelta: maxLat - minLat, longitudeDelta: maxLon - minLon)
            let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2)
            let region = MKCoordinateRegion(center: center, span: span)
            
            uiView.setRegion(region, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is MKPointAnnotation else { return nil }
            
            let identifier = "customAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnotationView
            if annotationView == nil {
                annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
    }
}

class CustomAnnotationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
                setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        private func setup() {
            if let annotation = annotation as? MKPointAnnotation,
               let imageName = annotation.subtitle {
                print("hello \(imageName)")
                self.image = UIImage(named: imageName)
            } else {
                self.image = UIImage(named: "defaultAnnotationImage")
            }
            self.canShowCallout = true
        }
}
