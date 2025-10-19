// PropertyStore.swift
import Foundation
import Combine
import SwiftUI

// Property categories used throughout the UI
enum PropertyCategory: String, CaseIterable, Identifiable, Codable {
    case offPlan = "Off‑Plan"
    case ready = "Ready"
    case leasing = "Leasing"

    var id: String { rawValue }

    var systemImage: String {
        switch self {
        case .offPlan: return "sparkles"
        case .ready: return "key.fill"
        case .leasing: return "building.2.fill"
        }
    }

    // Localized title for use in navigation and elsewhere
    var localizedTitle: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

// Main Property model
struct Property: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var title: String
    var category: PropertyCategory
    var price: Double?
    var currency: String = "AED"
    var bedrooms: Int?
    var bathrooms: Int?
    var size: Double?
    var sizeUnit: String = "sqft"
    var location: String
    var description: String
    var createdAt: Date = .now
}

// Store that manages properties
final class PropertyStore: ObservableObject {
    @Published var properties: [Property] = [
        Property(title: "Downtown 2BR Apartment", category: .ready, price: 2200000, bedrooms: 2, bathrooms: 2, size: 1250, location: "Downtown Dubai", description: "Burj view, high floor, vacant."),
        Property(title: "Harbour Views 1BR", category: .leasing, price: 9000, bedrooms: 1, bathrooms: 1, size: 780, location: "Dubai Creek Harbour", description: "Furnished, chiller free."),
        Property(title: "Emaar Beachfront – New Launch", category: .offPlan, price: 1800000, bedrooms: 1, bathrooms: 1, size: 720, location: "Dubai Harbour", description: "60/40 payment plan, Q4 2027.")
    ]

    func add(_ property: Property) {
        properties.append(property)
    }

    func remove(_ indexSet: IndexSet, category: PropertyCategory) {
        let ids = filtered(category: category).enumerated().compactMap { idx, item in
            indexSet.contains(idx) ? item.id : nil
        }
        properties.removeAll { ids.contains($0.id) }
    }

    func filtered(category: PropertyCategory) -> [Property] {
        properties.filter { $0.category == category }
            .sorted { $0.createdAt > $1.createdAt }
    }
}
