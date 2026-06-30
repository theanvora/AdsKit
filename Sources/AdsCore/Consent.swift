0//
//  Consent.swift
//  AdsKit
//
//  Created by AnhPT on 02/07/2026.
//

import Combine

/// GDPR / UMP consent state, abstracted away from the SDK.
public enum ConsentStatus: String, Sendable {
    case unknown, required, notRequired, obtained
}

/// Manages the consent flow (e.g. Google's User Messaging Platform).
@MainActor
public protocol ConsentManaging: AnyObject {
    var status: ConsentStatus { get }
    /// `true` once it is legally permissible to request ads.
    var canRequestAds: Bool { get }
    /// Presents the consent form if required; returns the resolved status.
    func requestConsent() async -> ConsentStatus
}

/// No-op consent manager for regions/builds where consent isn't required.
@MainActor
public final class NullConsentManager: ConsentManaging {
    public init() {}
    public var status: ConsentStatus { .notRequired }
    public var canRequestAds: Bool { true }
    public func requestConsent() async -> ConsentStatus { .notRequired }
}

/// Presents an app-open ad on foreground/cold-start. Kept separate from
/// `AdManaging` because its lifecycle is driven by app state, not user actions.
@MainActor
public protocol AppOpenAdManaging: AnyObject {
    func loadAppOpenAd() async
    @discardableResult
    func showAppOpenAdIfAvailable() async -> Bool
}
