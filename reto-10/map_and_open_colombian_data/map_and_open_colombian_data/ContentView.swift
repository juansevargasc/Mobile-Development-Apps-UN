import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ArcGISViewModel()
    @State private var filterQuery = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("Cundinamarca Locations")
                    .font(.largeTitle)
                    .padding()

                // Button to fetch data
                Button(action: {
                    viewModel.fetchData()
                }) {
                    Text("Retrieve from Colombian Gov. open data")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 10)

                // Text Field for Filtering
                TextField("Enter filter (e.g., town name)", text: $filterQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Navigation to Filtered Map View
                NavigationLink(destination: FilteredMapView(filterQuery: filterQuery)) {
                    Text("Search & View Filtered Map")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 10)

                // Navigation to User Location Map View
                NavigationLink(destination: UserLocationMapView()) {
                    Text("Show My Location & Nearby Places")
                        .font(.headline)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}
