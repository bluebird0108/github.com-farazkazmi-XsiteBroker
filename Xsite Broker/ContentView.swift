//  ContentView.swift
//  Xsite Real Estate
//
//  Created by Faraz on 12/10/2025.
//
// Xsite Real Estate — iOS App (SwiftUI, iOS 17+)
// Drop official developer logos into Assets.xcassets.
// Credit: App by Faraz Kazmi — shah-app.com

import SwiftUI
import Observation
import Foundation

// MARK: - Tiny Haptics helper
enum Haptics {
    static func light() {
        let gen = UIImpactFeedbackGenerator(style: .light)
        gen.prepare()
        gen.impactOccurred()
    }
    static func soft() {
        let gen = UIImpactFeedbackGenerator(style: .soft)
        gen.prepare()
        gen.impactOccurred()
    }
}

// MARK: - App Models
struct DeveloperBrand: Identifiable, Hashable, Codable {
    var id: UUID = .init()
    var nameEn: String
    var nameAr: String
    var logoAsset: String
    var website: URL?
}

struct PropertyItem: Identifiable, Hashable, Codable {
    enum Kind: String, Codable { case offplan, ready, leasing }
    var id: UUID = .init()
    var title: String
    var developerName: String
    var location: String
    var priceDisplay: String
    var kind: Kind
    var thumbnailAsset: String?
    var externalURL: URL?
}

struct ContactDetails: Hashable, Codable {
    var phoneInternational: String
    var email: String
    var whatsappInternational: String
    var address: String
    var tradeLicense: String
    var reraORN: String
    var hours: String
    var website: URL?
    var mapsURL: URL?
    
    // Convenience computed URLs for links
    var telURL: URL? { URL(string: "tel://\(phoneInternational.replacingOccurrences(of: "+", with: ""))") }
    var mailtoURL: URL? { URL(string: "mailto:\(email)") }
    var whatsappURL: URL? {
        let digits = whatsappInternational.replacingOccurrences(of: "+", with: "")
        return URL(string: "https://wa.me/\(digits)")
    }
}

// MARK: - Seed Data
extension DeveloperBrand {
    static let all: [DeveloperBrand] = [
        .init(nameEn: "Emaar Properties", nameAr: "إعمار", logoAsset: "logo_emaar", website: URL(string: "https://www.emaar.com")),
        .init(nameEn: "DAMAC", nameAr: "داماك", logoAsset: "logo_damac", website: URL(string: "https://www.damacproperties.com")),
        .init(nameEn: "Nakheel", nameAr: "نخيل", logoAsset: "logo_nakheel", website: URL(string: "https://www.nakheel.com")),
        .init(nameEn: "Meraas", nameAr: "مِراس", logoAsset: "logo_meraas", website: URL(string: "https://www.meraas.com")),
        .init(nameEn: "Sobha Realty", nameAr: "صبحا", logoAsset: "logo_sobha", website: URL(string: "https://www.sobharealty.com")),
        .init(nameEn: "Azizi Developments", nameAr: "عزيزي", logoAsset: "logo_azizi", website: URL(string: "https://azizidevelopments.com")),
        .init(nameEn: "Ellington", nameAr: "إلينغتون", logoAsset: "logo_ellington", website: URL(string: "https://ellingtongroup.com")),
        .init(nameEn: "Deyaar", nameAr: "ديار", logoAsset: "logo_deyaar", website: URL(string: "https://www.dyaar.ae")),
        .init(nameEn: "MAG", nameAr: "ماج", logoAsset: "logo_mag", website: URL(string: "https://www.magpropertydevelopment.com")),
    ]
}

// MARK: - Localization (EN/AR Toggle)
@Observable
final class L10n {
    enum Lang: String, CaseIterable, Identifiable { case en, ar; var id: String { rawValue } }
    var lang: Lang = .en

    func t(_ key: Key) -> String { strings[lang]?[key] ?? "" }

    enum Key: Hashable {
        case xsite, developers, properties, offplan, ready, leasing, contactUs, employeeLogin, registeredNote, allRegisteredWithUs, search, website, callUs, emailUs, whatsapp, about, appBy, madeBy, language, english, arabic, home, browseOffplan, browseReady, mortgageCalculator, services
    }

    private let strings: [Lang: [Key: String]] = [
        .en: [
            .xsite: "Xsite Real Estate Brokers",
            .developers: "Developers",
            .properties: "Properties",
            .offplan: "Off‑plan",
            .ready: "Ready",
            .leasing: "Leasing",
            .contactUs: "Contact Us",
            .employeeLogin: "Employee Login",
            .registeredNote: "All developer brands shown are registered with us.",
            .allRegisteredWithUs: "All registered with us",
            .search: "Search",
            .website: "Website",
            .callUs: "Call Us",
            .emailUs: "Email Us",
            .whatsapp: "WhatsApp",
            .about: "About",
            .appBy: "App by Faraz Kazmi",
            .madeBy: "Developer website: shah-app.com",
            .language: "Language",
            .english: "English",
            .arabic: "العربية",
            .home: "Home",
            .browseOffplan: "Browse Off‑plan",
            .browseReady: "Browse Ready",
            .mortgageCalculator: "Mortgage Calculator",
            .services: "Services"
        ],
        .ar: [
            .xsite: "إكس سايت للوساطة العقارية",
            .developers: "المطوّرون",
            .properties: "العقارات",
            .offplan: "خطة مستقبلية",
            .ready: "جاهز",
            .leasing: "تأجير",
            .contactUs: "اتصل بنا",
            .employeeLogin: "دخول الموظف",
            .registeredNote: "جميع المطورين المعروضين مسجلون لدينا.",
            .allRegisteredWithUs: "جميعهم مسجلون لدينا",
            .search: "بحث",
            .website: "الموقع",
            .callUs: "اتصل بنا",
            .emailUs: "أرسل بريدًا",
            .whatsapp: "واتساب",
            .about: "حول التطبيق",
            .appBy: "تطبيق من فِراز كاظمي",
            .madeBy: "موقع المطوّر: shah-app.com",
            .language: "اللغة",
            .english: "English",
            .arabic: "العربية",
            .home: "الرئيسية",
            .browseOffplan: "مشاريع على المخطط",
            .browseReady: "عقارات جاهزة",
            .mortgageCalculator: "حاسبة الرهن العقاري",
            .services: "الخدمات"
        ]
    ]
}

// MARK: - Theme (Dark / Black & White)
@Observable
final class AppTheme {
    let black = Color.black
    let white = Color.white
    let gray = Color(white: 0.12)
    let card = Color(white: 0.08)
    let border = Color.white.opacity(0.08)
    let shadow = Color.black.opacity(0.4)
    let radius: CGFloat = 22
}

@Observable
final class AppState {
    var lang = L10n()
    var theme = AppTheme()
    
    // Live data
    var developers: [DeveloperBrand] = []
    var properties: [PropertyItem] = []
    var contact: ContactDetails?
    var isLoadingDevelopers = false
    var isLoadingProperties = false
    var isLoadingContact = false
    var errorMessage: String?
    
    var search: String = ""
    
    // External links (static)
    let mortgageCalculatorURL = URL(string: "https://www.mortgagefinder.ae/en/calculator")!
    let dldFeesURL = URL(string: "https://www.dxbfi.com/investment-tools/dld-calculator")!
    let propertyFinderMortgageURL = URL(string: "https://www.propertyfinder.ae/en/mortgage")!
    let dldRealEstateCalcURL = URL(string: "https://dubailand.gov.ae/en/eservices/real-estate-calculator/")!
    
    // Placeholder endpoints — replace with your own
    var contactEndpoint = URL(string: "https://example.com/api/contact.json")!
    var developersEndpoint = URL(string: "https://example.com/api/developers.json")!
    var propertiesEndpoint = URL(string: "https://example.com/api/properties.json")!
    
    // Injected package API (optional; set from App)
    var xsiteAPI: XsiteAPI? = nil

    // MARK: Loaders
    @MainActor
    func loadAll() async {
        async let d: Void = loadDevelopers()
        async let p: Void = loadProperties()
        async let c: Void = loadContact()
        _ = await (d, p, c)
    }
    
    @MainActor
    func loadDevelopers() async {
        isLoadingDevelopers = true
        defer { isLoadingDevelopers = false }
        do {
            let list: [DeveloperBrand] = try await NetworkingClient.shared.get(Request(url: developersEndpoint))
            developers = list
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load developers: \(error.localizedDescription)"
            if developers.isEmpty { developers = DeveloperBrand.all }
        }
    }
    
    @MainActor
    func loadProperties() async {
        isLoadingProperties = true
        defer { isLoadingProperties = false }
        do {
            let list: [PropertyItem] = try await NetworkingClient.shared.get(Request(url: propertiesEndpoint))
            properties = list
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load properties: \(error.localizedDescription)"
            if properties.isEmpty { properties = PropertyItem.sample }
        }
    }
    
    @MainActor
    func loadContact() async {
        isLoadingContact = true
        defer { isLoadingContact = false }
        do {
            let details: ContactDetails = try await NetworkingClient.shared.get(Request(url: contactEndpoint))
            contact = details
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load contact: \(error.localizedDescription)"
            if contact == nil {
                contact = .fallback
            }
        }
    }
}

// Provide sample and fallback data used by loaders.
extension PropertyItem {
    static let sample: [PropertyItem] = [
        .init(title: "Downtown 2BR Apartment",
              developerName: "Emaar",
              location: "Downtown Dubai",
              priceDisplay: "AED 2.1M",
              kind: .ready,
              thumbnailAsset: nil,
              externalURL: URL(string: "https://example.com/property/1")),
        .init(title: "Palm Luxury Villa",
              developerName: "Nakheel",
              location: "Palm Jumeirah",
              priceDisplay: "AED 18M",
              kind: .ready,
              thumbnailAsset: nil,
              externalURL: URL(string: "https://example.com/property/2")),
        .init(title: "New Marina Off‑plan",
              developerName: "DAMAC",
              location: "Dubai Marina",
              priceDisplay: "From AED 1.3M",
              kind: .offplan,
              thumbnailAsset: nil,
              externalURL: URL(string: "https://example.com/property/3"))
    ]
}

extension ContactDetails {
    static let fallback = ContactDetails(
        phoneInternational: "+971501234567",
        email: "info@xsite.ae",
        whatsappInternational: "+971501234567",
        address: "Office 123, Business Bay, Dubai",
        tradeLicense: "123456",
        reraORN: "987654",
        hours: "Mon–Fri 9am–6pm",
        website: URL(string: "https://xsite.ae"),
        mapsURL: URL(string: "https://maps.apple.com/?q=Xsite+Real+Estate")
    )
}

// MARK: - ContentView (Home)
struct ContentView: View {
    @Environment(AppState.self) private var app
    @State private var showingLangSheet = false
    // Local binding to avoid '$app' error when previewing or when environment isn't set yet
    @State private var searchText: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                header
                searchBar
                developersSection
                propertiesSection
                contactSection
                externalToolsSection
            }
            .padding()
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle(app.lang.t(.home))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingLangSheet = true
                } label: {
                    Image(systemName: "globe")
                }
                .accessibilityLabel(app.lang.t(.language))
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task { await app.loadAll() }
                    Haptics.soft()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                .accessibilityLabel("Reload")
            }
        }
        .task {
            // Initialize local search with app state's current value
            searchText = app.search
            if app.developers.isEmpty && app.properties.isEmpty && app.contact == nil {
                await app.loadAll()
            }
        }
        .sheet(isPresented: $showingLangSheet) {
            LanguagePickerView()
                .presentationDetents([.medium])
        }
        // Keep app.search synchronized with local searchText
        .onChange(of: searchText) { _, newValue in
            app.search = newValue
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(app.lang.t(.xsite))
                .font(.title.bold())
            Text(app.lang.t(.registeredNote))
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var searchBar: some View {
        TextField(app.lang.t(.search), text: $searchText)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(white: 0.12)))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.06)))
            .foregroundStyle(.white)
    }
    
    private var developersSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(app.lang.t(.developers))
                    .font(.headline)
                if app.isLoadingDevelopers { ProgressView().tint(.white) }
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(filteredDevelopers) { dev in
                        DeveloperCard(brand: dev)
                    }
                }
                .padding(.vertical, 4)
            }
            if app.developers.isEmpty && !app.isLoadingDevelopers {
                Text("No developers to show.")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
        }
    }
    
    private var propertiesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(app.lang.t(.properties))
                    .font(.headline)
                if app.isLoadingProperties { ProgressView().tint(.white) }
                Spacer()
            }
            LazyVStack(spacing: 12) {
                ForEach(filteredProperties) { item in
                    PropertyRow(item: item)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(white: 0.10)))
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.06)))
                        .padding(.horizontal, 1)
                }
            }
            if app.properties.isEmpty && !app.isLoadingProperties {
                Text("No properties to show.")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
        }
    }
    
    private var contactSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(app.lang.t(.contactUs))
                    .font(.headline)
                if app.isLoadingContact { ProgressView().tint(.white) }
                Spacer()
            }
            if let c = app.contact {
                VStack(alignment: .leading, spacing: 8) {
                    if let url = c.telURL {
                        LinkRow(title: app.lang.t(.callUs), systemImage: "phone.fill", url: url)
                    }
                    if let url = c.mailtoURL {
                        LinkRow(title: app.lang.t(.emailUs), systemImage: "envelope.fill", url: url)
                    }
                    if let url = c.whatsappURL {
                        LinkRow(title: app.lang.t(.whatsapp), systemImage: "message.fill", url: url)
                    }
                    if let url = c.website {
                        LinkRow(title: app.lang.t(.website), systemImage: "globe", url: url)
                    }
                    if let url = c.mapsURL {
                        LinkRow(title: "Maps", systemImage: "map.fill", url: url)
                    }
                    Text("RERA ORN: \(c.reraORN)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text("Trade License: \(c.tradeLicense)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text(c.address)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text(c.hours)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(white: 0.10)))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.06)))
            } else if !app.isLoadingContact {
                Text("No contact info available.")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
        }
    }
    
    private var externalToolsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(app.lang.t(.services))
                .font(.headline)
            HStack(spacing: 12) {
                ExternalToolButton(title: app.lang.t(.mortgageCalculator), url: app.mortgageCalculatorURL, icon: "percent")
                ExternalToolButton(title: "DLD Calculator", url: app.dldRealEstateCalcURL, icon: "building.2.fill")
            }
        }
    }
    
    private var filteredDevelopers: [DeveloperBrand] {
        let s = app.search.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !s.isEmpty else { return app.developers }
        return app.developers.filter {
            $0.nameEn.lowercased().contains(s) || $0.nameAr.lowercased().contains(s)
        }
    }
    
    private var filteredProperties: [PropertyItem] {
        let s = app.search.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !s.isEmpty else { return app.properties }
        return app.properties.filter {
            $0.title.lowercased().contains(s) ||
            $0.developerName.lowercased().contains(s) ||
            $0.location.lowercased().contains(s) ||
            $0.priceDisplay.lowercased().contains(s)
        }
    }
}

// MARK: - Components
private struct DeveloperCard: View {
    @Environment(AppState.self) private var app
    let brand: DeveloperBrand
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(white: 0.12))
                    .frame(width: 100, height: 64)
                Image(brand.logoAsset)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 36)
                    .padding(8)
            }
            Text(app.lang.lang == .ar ? brand.nameAr : brand.nameEn)
                .font(.footnote)
                .lineLimit(1)
        }
        .onTapGesture {
            Haptics.light()
            if let url = brand.website {
                UIApplication.shared.open(url)
            }
        }
    }
}

private struct PropertyRow: View {
    let item: PropertyItem
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(white: 0.14))
                    .frame(width: 72, height: 72)
                if let thumb = item.thumbnailAsset {
                    Image(thumb)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 72, height: 72)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else {
                    Image(systemName: "house.fill")
                        .font(.title2)
                        .foregroundStyle(.white.opacity(0.7))
                }
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.headline)
                Text("\(item.developerName) • \(item.location)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(item.priceDisplay)
                    .font(.subheadline.weight(.semibold))
            }
            Spacer()
            Text(kindLabel(item.kind))
                .font(.caption2)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Capsule().fill(Color.white.opacity(0.08)))
        }
        .padding(10)
        .contentShape(Rectangle())
        .onTapGesture {
            if let url = item.externalURL {
                UIApplication.shared.open(url)
            }
        }
    }
    
    private func kindLabel(_ kind: PropertyItem.Kind) -> String {
        switch kind {
        case .offplan: return "Off‑plan"
        case .ready: return "Ready"
        case .leasing: return "Leasing"
        }
    }
}

private struct LinkRow: View {
    let title: String
    let systemImage: String
    let url: URL
    var body: some View {
        Button {
            UIApplication.shared.open(url)
        } label: {
            HStack {
                Image(systemName: systemImage)
                Text(title)
                Spacer()
                Image(systemName: "arrow.up.right.square")
                    .foregroundStyle(.secondary)
            }
        }
        .buttonStyle(.plain)
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(white: 0.12)))
    }
}

private struct ExternalToolButton: View {
    let title: String
    let url: URL
    let icon: String
    var body: some View {
        Button {
            UIApplication.shared.open(url)
        } label: {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(title)
                    .lineLimit(1)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(white: 0.12)))
        }
        .buttonStyle(.plain)
    }
}

private struct LanguagePickerView: View {
    @Environment(AppState.self) private var app
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            List {
                Button {
                    app.lang.lang = .en
                    dismiss()
                } label: {
                    HStack {
                        Text(app.lang.t(.english))
                        Spacer()
                        if app.lang.lang == .en { Image(systemName: "checkmark") }
                    }
                }
                Button {
                    app.lang.lang = .ar
                    dismiss()
                } label: {
                    HStack {
                        Text(app.lang.t(.arabic))
                        Spacer()
                        if app.lang.lang == .ar { Image(systemName: "checkmark") }
                    }
                }
            }
            .navigationTitle(app.lang.t(.language))
        }
    }
}

// swift-tools-version:5.10
//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftCertificates open source project
//
// Copyright (c) 2022-2023 Apple Inc. and the SwiftCertificates project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftCertificates project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import PackageDescription
import class Foundation.ProcessInfo

let package = Package(
    name: "swift-certificates",
    products: [
        .library(
            name: "X509",
            targets: ["X509"]
        )
    ],
    targets: [
        .target(
            name: "X509",
            dependencies: [
                "_CertificateInternals",
                .product(name: "SwiftASN1", package: "swift-asn1"),
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "_CryptoExtras", package: "swift-crypto"),
            ],
            exclude: [
                "CMakeLists.txt"
            ]
        ),
        .testTarget(
            name: "X509Tests",
            dependencies: [
                "X509",
                .product(name: "SwiftASN1", package: "swift-asn1"),
                .product(name: "Crypto", package: "swift-crypto"),
            ],
            resources: [
                .copy("OCSP Test Resources/www.apple.com.root.der"),
                .copy("OCSP Test Resources/www.apple.com.intermediate.der"),
                .copy("OCSP Test Resources/www.apple.com.der"),
                .copy("OCSP Test Resources/www.apple.com.ocsp-response.der"),
                .copy("OCSP Test Resources/www.apple.com.intermediate.ocsp-response.der"),
                .copy("PEMTestRSACertificate.pem"),
                .copy("CSR Vectors/"),
                .copy("ca-certificates.crt"),
            ]
        ),
        .target(
            name: "_CertificateInternals",
            exclude: [
                "CMakeLists.txt"
            ]
        ),
        .testTarget(
            name: "CertificateInternalsTests",
            dependencies: [
                "_CertificateInternals"
            ]
        ),
    ]
)

// If the `SWIFTCI_USE_LOCAL_DEPS` environment variable is set,
// we're building in the Swift.org CI system alongside other projects in the Swift toolchain and
// we can depend on local versions of our dependencies instead of fetching them remotely.
if ProcessInfo.processInfo.environment["SWIFTCI_USE_LOCAL_DEPS"] == nil {
    package.dependencies += [
        .package(url: "https://github.com/apple/swift-crypto.git", "3.12.3"..<"5.0.0"),
        .package(url: "https://github.com/apple/swift-asn1.git", from: "1.1.0"),
    ]
} else {
    package.dependencies += [
        .package(path: "../swift-crypto"),
        .package(path: "../swift-asn1"),
    ]
}

for target in package.targets {
    var settings = target.swiftSettings ?? []
    settings.append(.enableExperimentalFeature("StrictConcurrency=complete"))
    target.swiftSettings = settings
}

// ---    STANDARD CROSS-REPO SETTINGS DO NOT EDIT   --- //
for target in package.targets {
    switch target.type {
    case .regular, .test, .executable:
        var settings = target.swiftSettings ?? []
        // https://github.com/swiftlang/swift-evolution/blob/main/proposals/0444-member-import-visibility.md
        settings.append(.enableUpcomingFeature("MemberImportVisibility"))
        target.swiftSettings = settings
    case .macro, .plugin, .system, .binary:
        ()  // not applicable
    @unknown default:
        ()  // we don't know what to do here, do nothing
    }
}
// --- END: STANDARD CROSS-REPO SETTINGS DO NOT EDIT --- //
