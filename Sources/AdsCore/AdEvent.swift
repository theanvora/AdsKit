import Combine

/// Ad formats supported by the abstraction.
public enum AdFormat: String, Sendable {
    case appOpen, banner, interstitial, rewarded
}

/// Lifecycle events emitted by an ad manager. Delivered over Combine so screens
/// react with operators instead of delegate methods or completion blocks.
public enum AdEvent: Sendable, Equatable {
    case loaded(AdFormat)
    case failed(AdFormat, reason: String)
    case shown(AdFormat)
    case dismissed(AdFormat)
    case clicked(AdFormat)
    case rewarded(AdReward)
}

/// Adopted by ad managers that broadcast their lifecycle via Combine.
///
/// ```swift
/// ads.events
///     .filter { $0 == .dismissed(.interstitial) }
///     .sink { _ in resumeGame() }
///     .store(in: &cancellables)
/// ```
public protocol AdEventPublishing {
    var events: AnyPublisher<AdEvent, Never> { get }
}
