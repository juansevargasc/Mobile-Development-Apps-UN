//
//  FilteredMapView.swift
//  map_and_open_colombian_data
//
//  Created by Juanse Vargas on 2/3/25.
//

import SwiftUI
import GoogleMaps

struct FilteredMapView: View {
    @StateObject private var viewModel = ArcGISViewModel()
    var filterQuery: String  // Parameter for filtering API data
    
    var body: some View {
        VStack {
            Text("Filtered Locations")
                .font(.largeTitle)
                .padding()

            GoogleMapView(locations: viewModel.locations)
                .frame(height: UIScreen.main.bounds.height * 0.7)
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            viewModel.fetchFilteredData(query: filterQuery)
        }
    }
}
