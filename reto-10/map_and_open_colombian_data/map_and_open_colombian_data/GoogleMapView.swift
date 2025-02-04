import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    var locations: [ArcGISFeature]
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: 4.5, longitude: -74.1, zoom: 8.0)
        let mapView = GMSMapView(frame: .zero, camera: camera)
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.clear() // Clear previous markers
        
        for location in locations {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: location.geometry.y, longitude: location.geometry.x)
            marker.title = location.attributes.NOMBRE
            marker.map = mapView
        }
    }
}

