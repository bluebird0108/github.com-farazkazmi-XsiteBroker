// LanguageOption.swift
import Foundation

enum LanguageOption: String, CaseIterable, Identifiable {
    case system
    case en
    case ar

    var id: String { rawValue }

    var label: String {
        switch self {
        case .system: return String(localized: "System")
        case .en:     return String(localized: "English")
        case .ar:     return String(localized: "Arabic")
        }
    }

    var locale: Locale? {
        switch self {
        case .system: return nil
        case .en:     return Locale(identifier: "en")
        case .ar:     return Locale(identifier: "ar")
        }
    }
}
