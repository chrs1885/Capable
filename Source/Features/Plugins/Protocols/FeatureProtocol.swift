import Foundation

protocol AccessibilityFeatureProtocol {
    static var name: String { get }
    var isEnabled: Bool { get }
    var status: String { get }
}
