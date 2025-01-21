//Juanse
//

import SwiftUI

struct NewCompanyView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var websiteURL = ""
    @State private var contactPhone = ""
    @State private var contactEmail = ""
    @State private var productsAndServices = ""
    @State private var classification = Classification.consulting
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Company Name", text: $name)
                TextField("Website URL", text: $websiteURL)
                TextField("Contact Phone", text: $contactPhone)
                TextField("Contact Email", text: $contactEmail)
                TextField("Products and Services", text: $productsAndServices)
                
                Picker("Classification", selection: $classification) {
                    ForEach(Classification.allCases) { classification in
                        Text(classification.descr).tag(classification)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Button("Create") {
                    let newCompany = Company(
                        name: name,
                        websiteURL: websiteURL,
                        contactPhone: contactPhone,
                        contactEmail: contactEmail,
                        productsAndServices: productsAndServices,
                        classification: classification
                    )
                    context.insert(newCompany)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(name.isEmpty || websiteURL.isEmpty || contactPhone.isEmpty || contactEmail.isEmpty)
                .navigationTitle("New Company")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewCompanyView()
}
