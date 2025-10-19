import SwiftUI

@main
struct Xsite_BrokerApp: App {
    @StateObject private var theme = ThemeModel()
    @StateObject private var store = PropertyStore()

    // Persisted language choice (System / English / Arabic)
    @AppStorage("xsite.language") private var savedLanguage: String = LanguageOption.system.rawValue

    private var selectedLanguage: LanguageOption {
        LanguageOption(rawValue: savedLanguage) ?? .system
    }

    private var currentLocale: Locale {
        selectedLanguage.locale ?? .autoupdatingCurrent
    }

    private var isArabic: Bool {
        let id = (selectedLanguage.locale ?? .autoupdatingCurrent).identifier.lowercased()
        return id.hasPrefix("ar")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(theme)
                .environmentObject(store)
                .environment(\.locale, currentLocale)
                .environment(\.layoutDirection, isArabic ? .rightToLeft : .leftToRight)
                .preferredColorScheme(theme.overrideScheme)
        }
    }
}
