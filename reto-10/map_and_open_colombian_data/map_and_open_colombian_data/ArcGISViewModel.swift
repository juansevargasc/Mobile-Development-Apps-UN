import Foundation

class ArcGISViewModel: ObservableObject {
    @Published var locations: [ArcGISFeature] = []

    func fetchData() {
        let urlString = "https://services7.arcgis.com/lsxbLWF2l19Rmhqj/ArcGIS/rest/services/Equipamiento_Cundinamarca/FeatureServer/0/query?where=1%3D1&outFields=OBJECTID,NOMBRE&geometry&f=json"
        fetchFromAPI(urlString: urlString)
    }

    func fetchFilteredData(query: String) {
        let urlString = "https://services7.arcgis.com/lsxbLWF2l19Rmhqj/ArcGIS/rest/services/Equipamiento_Cundinamarca/FeatureServer/0/query?where=NOMBRE LIKE '%\(query)%'&outFields=OBJECTID,NOMBRE&geometry&f=json"
        fetchFromAPI(urlString: urlString)
    }
    
    func fetchNearbyLocations(latitude: Double, longitude: Double) {
        let buffer = 0.3 // Approx. 10 km radius
        let urlString = "https://services7.arcgis.com/lsxbLWF2l19Rmhqj/ArcGIS/rest/services/Equipamiento_Cundinamarca/FeatureServer/0/query?where=geometry%20within%20Envelope(\(longitude - buffer),\(latitude - buffer),\(longitude + buffer),\(latitude + buffer))&outFields=OBJECTID,NOMBRE&geometry&f=json"

        fetchFromAPI(urlString: urlString)
    }




    private func fetchFromAPI(urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let jsonResponse = try JSONDecoder().decode(ArcGISResponse.self, from: data)
                DispatchQueue.main.async {
                    self.locations = jsonResponse.features
                }
            } catch {
                print("Error decoding JSON: \(error)")
                print("Raw JSON response:", String(data: data, encoding: .utf8) ?? "Invalid JSON")
            }
        }.resume()
    }
}
