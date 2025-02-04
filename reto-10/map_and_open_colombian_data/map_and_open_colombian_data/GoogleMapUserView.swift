import SwiftUI
import GoogleMaps

struct GoogleMapUserView: UIViewRepresentable {
    var userLocation: CLLocationCoordinate2D?
    var locations: [GooglePlace]

    @State private var shouldRecenter = true // Flag to control auto-centering

    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView(frame: .zero)
        mapView.isMyLocationEnabled = true

        // Detect user interaction with the map
        mapView.delegate = context.coordinator

        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.clear()

        // Show User Location (If Available) and Only Center If `shouldRecenter` is True
        if let userLocation = userLocation, shouldRecenter {
            let camera = GMSCameraPosition.camera(withLatitude: userLocation.latitude, longitude: userLocation.longitude, zoom: 14.0)
            mapView.animate(to: camera)
        }

        // Show Nearby Places
        for place in locations {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            marker.title = place.name
            marker.map = mapView
        }
    }

    // Add Coordinator to Handle Map Interactions
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(self)
    }

    class MapCoordinator: NSObject, GMSMapViewDelegate {
        var parent: GoogleMapUserView

        init(_ parent: GoogleMapUserView) {
            self.parent = parent
        }

        func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
            if gesture {
                // User moved the map, disable auto-recentering
                parent.shouldRecenter = false
            }
        }
    }
}
