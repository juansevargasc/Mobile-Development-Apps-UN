//
// Juanse Vargas


import SwiftUI
import SwiftData

@Model
class Company {
    var name: String
    var websiteURL: String
    var contactPhone: String
    var contactEmail: String
    var productsAndServices: String
    var classification: Classification
    var dateAdded: Date
    
    init(
        name: String,
        websiteURL: String,
        contactPhone: String,
        contactEmail: String,
        productsAndServices: String,
        classification: Classification,
        dateAdded: Date = Date.now
    ) {
        self.name = name
        self.websiteURL = websiteURL
        self.contactPhone = contactPhone
        self.contactEmail = contactEmail
        self.productsAndServices = productsAndServices
        self.classification = classification
        self.dateAdded = dateAdded
    }
    
    var icon: Image {
        switch classification {
        case .consulting:
            Image(systemName: "briefcase.fill")
        case .customDevelopment:
            Image(systemName: "hammer.fill")
        case .softwareFactory:
            Image(systemName: "desktopcomputer")
        }
    }
}

enum Classification: Int, Codable, Identifiable, CaseIterable {
    case consulting, customDevelopment, softwareFactory
    var id: Self { self }
    var descr: String {
        switch self {
        case .consulting:
            "Consulting"
        case .customDevelopment:
            "Custom Development"
        case .softwareFactory:
            "Software Factory"
        }
    }
}
