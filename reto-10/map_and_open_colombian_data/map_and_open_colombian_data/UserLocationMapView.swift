import SwiftUI
import GoogleMaps
import CoreLocation

struct UserLocationMapView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var placesViewModel = GooglePlacesViewModel()
    @State private var userLocation: CLLocationCoordinate2D?

    var body: some View {
        VStack {
            Text("Nearby Places")
                .font(.largeTitle)
                .padding()

            GoogleMapUserView(userLocation: userLocation, locations: placesViewModel.places)
                .frame(height: UIScreen.main.bounds.height * 0.7)
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            locationManager.requestLocation()
        }
        .onReceive(locationManager.$userLocation) { location in
            if let location = location {
                self.userLocation = location  // ✅ Store user location
                placesViewModel.fetchNearbyPlaces(latitude: location.latitude, longitude: location.longitude)
            }
        }
    }
}
