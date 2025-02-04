//
//  ArcGISModel.swift
//  map_and_open_colombian_data
//
//  Created by Juanse Vargas on 2/3/25.
//

import Foundation

// Top-level response structure
struct ArcGISResponse: Codable {
    let features: [ArcGISFeature]
}

// Individual feature structure
struct ArcGISFeature: Codable, Identifiable {
    var id: Int { attributes.OBJECTID }

    struct Attributes: Codable {
        let OBJECTID: Int
        let NOMBRE: String
    }

    struct Geometry: Codable {
        let x: Double
        let y: Double
    }

    let attributes: Attributes
    let geometry: Geometry
}
