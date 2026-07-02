//
//  AdFrequencyCap.swift
//  AdsKit
//
//  Created by Anvora on 02/07/2026.
//

import Foundation

/// Rate-limits ad presentations: a minimum gap between impressions, a per-session
/// ceiling, and an initial grace period after launch.
@MainActor
public final class AdFrequencyCap {
    public let minInterval: TimeInterval
    public let maxPerSession: Int
    public let launchGrace: TimeInterval

    private let startedAt = Date()
    private var lastShown: Date?
    private var sessionCount = 0

    public init(minInterval: TimeInterval = 60, maxPerSession: Int = .max, launchGrace: TimeInterval = 0) {
        self.minInterval = minInterval
        self.maxPerSession = maxPerSession
        self.launchGrace = launchGrace
    }

    /// Whether an ad may be shown right now.
    public func canShow(now: Date = Date()) -> Bool {
        guard now.timeIntervalSince(startedAt) >= launchGrace else { return false }
        guard sessionCount < maxPerSession else { return false }
        if let lastShown, now.timeIntervalSince(lastShown) < minInterval { return false }
        return true
    }

    /// Record that an ad was just presented.
    public func recordShown(now: Date = Date()) {
        lastShown = now
        sessionCount += 1
    }

    public func reset() {
        lastShown = nil
        sessionCount = 0
    }
}
