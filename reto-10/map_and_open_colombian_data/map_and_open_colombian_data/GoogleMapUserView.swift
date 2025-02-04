import SwiftUI
import GoogleMaps

struct GoogleMapUserView: UIViewRepresentable {
    var userLocation: CLLocationCoordinate2D?
    var locations: [GooglePlace]

    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView(frame: .zero)
        mapView.isMyLocationEnabled = true
        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.clear()  // Clear previous markers

        // ✅ Show User Location (If Available)
        if let userLocation = userLocation {
            let userMarker = GMSMarker(position: userLocation)
            userMarker.title = "You Are Here"
            userMarker.icon = GMSMarker.markerImage(with: .blue)
            userMarker.map = mapView
            
            // ✅ Center the map on the user's location
            let camera = GMSCameraPosition.camera(withLatitude: userLocation.latitude, longitude: userLocation.longitude, zoom: 14.0)
            mapView.animate(to: camera)
        }

        // ✅ Show Google Places Nearby
        for place in locations {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            marker.title = place.name
            marker.map = mapView
        }
    }
}
