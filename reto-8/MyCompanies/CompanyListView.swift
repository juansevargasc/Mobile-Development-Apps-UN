import SwiftUI
import SwiftData

struct CompanyListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Company.name) private var companies: [Company]
    @State private var createNewCompany = false
    
    var body: some View {
        NavigationStack {
            Group {
                if companies.isEmpty {
                    ContentUnavailableView("Enter your first company.", systemImage: "building.2.fill")
                } else {
                    List {
                        ForEach(companies) { company in
                            NavigationLink {
                                EditCompanyView(company: company)
                            } label: {
                                HStack(spacing: 10) {
                                    company.icon
                                    VStack(alignment: .leading) {
                                        Text(company.name).font(.title2)
                                        Text(company.websiteURL)
                                            .foregroundStyle(.secondary)
                                        Text(company.contactEmail)
                                            .font(.caption)
                                            .foregroundStyle(.tertiary)
                                    }
                                }
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let company = companies[index]
                                context.delete(company)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("My Companies")
            .toolbar {
                // Button to add a new company
                Button {
                    createNewCompany = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
                // Button to copy the database
                Button("Copy DB") {
                    copyDatabaseToDocuments()
                }
            }
            .sheet(isPresented: $createNewCompany) {
                NewCompanyView()
                    .presentationDetents([.medium])
            }
        }
    }
}
