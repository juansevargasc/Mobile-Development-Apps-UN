//
//  Config.swift
//  map_and_open_colombian_data
//
//  Created by Juanse Vargas on 2/3/25.
//


import Foundation

class Config {
    static var googleAPIKey: String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["GoogleAPIKey"] as? String else {
            fatalError(" Google API Key not found in Config.plist!")
        }
        return key
    }
}
