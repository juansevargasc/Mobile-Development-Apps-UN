//
// Created for MyCompanies
// Refactored by Stewart Lynch
//

import SwiftUI
import SwiftData

func copyDatabaseToDocuments() {
    let fileManager = FileManager.default
    if let supportDirectory = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
        let sourceURL = supportDirectory.appendingPathComponent("persistentContainer.sqlite")
        let destinationURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("persistentContainer.sqlite")

        do {
            if let destinationURL {
                try fileManager.copyItem(at: sourceURL, to: destinationURL)
                print("Database copied to: \(destinationURL.path)")
            }
        } catch {
            print("Error copying database: \(error.localizedDescription)")
        }
    }
}

@main
struct MyCompaniesApp: App {
    var body: some Scene {
        WindowGroup {
            CompanyListView()
        }
        .modelContainer(for: Company.self)
    }
    
    init() {
        print("Priting databse path")
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        

    }
}



