import Foundation
import CoreLocation

struct GooglePlace: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
}

class GooglePlacesViewModel: ObservableObject {
    @Published var places: [GooglePlace] = []

    func fetchNearbyPlaces(latitude: Double, longitude: Double) {
        let apiKey = Config.googleAPIKey 

        let radius = 1000  // ✅ 5000 meters = 5 km range
        let placeType = "restaurant"  // ✅ Change to "cafe", "hospital", etc.

        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=\(radius)&type=\(placeType)&key=\(apiKey)"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        print("🔍 Fetching nearby places from: \(urlString)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(" Error fetching Google Places: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(GooglePlacesResponse.self, from: data)

                DispatchQueue.main.async {
                    self.places = decodedResponse.results.map { place in
                        GooglePlace(
                            name: place.name,
                            latitude: place.geometry.location.lat,
                            longitude: place.geometry.location.lng
                        )
                    }

                    
                    print("📍 Nearby Places Found:")
                    for place in self.places {
                        print("- \(place.name) at (\(place.latitude), \(place.longitude))")
                    }
                }
            } catch {
                print(" Error decoding Google Places JSON: \(error)")
                print(" Raw JSON response: \(String(data: data, encoding: .utf8) ?? "Invalid JSON")")
            }
        }.resume()
    }
}

struct GooglePlacesResponse: Codable {
    let results: [GooglePlaceResult]
}

struct GooglePlaceResult: Codable {
    let name: String
    let geometry: GooglePlaceGeometry
}

struct GooglePlaceGeometry: Codable {
    let location: GooglePlaceLocation
}

struct GooglePlaceLocation: Codable {
    let lat: Double
    let lng: Double
}
