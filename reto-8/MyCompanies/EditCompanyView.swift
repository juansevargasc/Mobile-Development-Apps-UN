import SwiftUI

struct EditCompanyView: View {
    @Environment(\.dismiss) private var dismiss
    let company: Company
    @State private var name = ""
    @State private var websiteURL = ""
    @State private var contactPhone = ""
    @State private var contactEmail = ""
    @State private var productsAndServices = ""
    @State private var classification = Classification.consulting
    @State private var dateAdded = Date.now
    @State private var firstView = true
    
    var body: some View {
        VStack(alignment: .leading) {
            GroupBox {
                LabeledContent {
                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                } label: {
                    Text("Date Added")
                }
            }
            .foregroundStyle(.secondary)
            
            Divider()
            
            LabeledContent {
                TextField("Enter company name", text: $name)
            } label: {
                Text("Company Name").foregroundStyle(.secondary)
            }
            
            LabeledContent {
                TextField("Enter website URL", text: $websiteURL)
            } label: {
                Text("Website URL").foregroundStyle(.secondary)
            }
            
            LabeledContent {
                TextField("Enter contact phone", text: $contactPhone)
            } label: {
                Text("Contact Phone").foregroundStyle(.secondary)
            }
            
            LabeledContent {
                TextField("Enter contact email", text: $contactEmail)
            } label: {
                Text("Contact Email").foregroundStyle(.secondary)
            }
            
            Divider()
            
            LabeledContent {
                TextEditor(text: $productsAndServices)
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
            } label: {
                Text("Products and Services").foregroundStyle(.secondary)
            }
            
            Picker("Classification", selection: $classification) {
                ForEach(Classification.allCases) { classification in
                    Text(classification.descr).tag(classification)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.vertical)
            
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(name.isEmpty ? "Edit Company" : name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if changed {
                Button("Update") {
                    company.name = name
                    company.websiteURL = websiteURL
                    company.contactPhone = contactPhone
                    company.contactEmail = contactEmail
                    company.productsAndServices = productsAndServices
                    company.classification = classification
                    company.dateAdded = dateAdded
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            name = company.name
            websiteURL = company.websiteURL
            contactPhone = company.contactPhone
            contactEmail = company.contactEmail
            productsAndServices = company.productsAndServices
            classification = company.classification
            dateAdded = company.dateAdded
        }
    }
    
    var changed: Bool {
        name != company.name
        || websiteURL != company.websiteURL
        || contactPhone != company.contactPhone
        || contactEmail != company.contactEmail
        || productsAndServices != company.productsAndServices
        || classification != company.classification
        || dateAdded != company.dateAdded
    }
}

//#Preview {
//    NavigationStack {
//        EditCompanyView(company: Company(...))
//    }
//}

