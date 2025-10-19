// ThemeModel.swift
import SwiftUI
import Combine

final class ThemeModel: ObservableObject {
    enum SchemeOverride: String, CaseIterable, Identifiable {
        case system, light, dark
        var id: String { rawValue }
        var label: String {
            switch self {
            case .system: return String(localized: "System")
            case .light:  return String(localized: "Light")
            case .dark:   return String(localized: "Dark")
            }
        }
    }

    // Persisted override choice
    @AppStorage("xsite.scheme") var savedOverride: String = SchemeOverride.system.rawValue {
        didSet { objectWillChange.send() }
    }

    var override: SchemeOverride { SchemeOverride(rawValue: savedOverride) ?? .system }
    var overrideScheme: ColorScheme? {
        override == .system ? nil : (override == .dark ? .dark : .light)
    }

    // Optional theme helpers
    var trueBlack: Color { Color.black }
    var surface: Color {
        if override == .dark { return Color.black }
        return Color(UIColor.systemBackground)
    }
    var card: Color { override == .dark ? Color(white: 0.06) : Color(UIColor.secondarySystemBackground) }
    var accent: Color { Color(.systemTeal) }
}
