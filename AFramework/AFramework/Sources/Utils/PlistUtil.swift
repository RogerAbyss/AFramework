//
//  PlistUtil.swift
//  AFramework
//
//  Created by abyss on 2019/4/22.
//

#if os(OSX)
import Cocoa
#else
import Foundation
import UIKit
#endif

/// Info.plist assistant.
public class PlistUtil {

    public static func appDescription() -> String {
        var isTest: String = ""
        #if DEBUG
        isTest = "(测试版)"
        #endif
        
        return "版本号\(isTest) \(PlistUtil.version)"
//        return "\(PlistUtil.name)\(isTest) v\(PlistUtil.version)"
    }

    
    /// Info.plist as a dictionary objec
    public static var dictionary: [String: Any]? {
        return Bundle.main.infoDictionary
    }

    /// Getting string, could be empty
    ///
    /// - Parameter key: Key String
    /// - Returns: `String` object, could be empty
    public static func getStringValue(_ key: String) -> String {
        return (getValue(key) as? String) ?? ""
    }

    /// Getting string, could be `nil`
    ///
    /// - Parameter key: Key String
    /// - Returns: `String?` object, could be `nil`
    public static func getString(_ key: String) -> String? {
        return getValue(key) as? String
    }

    /// Getting Bool value
    ///
    /// - Parameter key: Key String
    /// - Returns: `Bool` value
    public static func getBool(_ key: String) -> Bool {
        return (PlistUtil.getValue(key) as? Bool) ?? false
    }

    /// Getting value, could be `nil`
    ///
    /// - Parameter key: Key String
    /// - Returns: `Any?`, could be `nil`
    public static func getValue(_ key: String) -> Any? {
        guard let infoDictionary = PlistUtil.dictionary else {
            return nil
        }
        return infoDictionary[key]
    }
}

// MARK: - Common
public extension PlistUtil {
    /// CFBundleDisplayName
    static var bundleDisplayName: String = {
        return PlistUtil.getStringValue("CFBundleDisplayName")
    }()

    /// CFBundleName
    static var bundleName: String = {
        return PlistUtil.getStringValue("CFBundleName")

    }()

    /// Return CFBundleDisplayName if not empty, otherwise return CFBundleName
    static var name: String = {
        return !bundleDisplayName.isEmpty ? bundleDisplayName : bundleName
    }()

    /// CFBundleShortVersionString
    static var version: String = {
        return PlistUtil.getStringValue("CFBundleShortVersionString")
    }()

    /// CFBundleVersion
    static var build: String = {
        return PlistUtil.getStringValue("CFBundleVersion")
    }()

    /// CFBundleExecutable
    static var executable: String = {
        return PlistUtil.getStringValue("CFBundleExecutable")
    }()

    /// CFBundleIdentifier
    static var bundleIndentifier: String = {
        return PlistUtil.getStringValue("CFBundleIdentifier")
    }()

    /// CFBundleURLTypes.first[CFBundleURLSchemes]
    static var schemes: [String] = {
        guard let urlTypes = PlistUtil.getValue("CFBundleURLTypes") as? [AnyObject],
            let urlType = urlTypes.first as? [String : AnyObject],
            let urlSchemes = urlType["CFBundleURLSchemes"] as? [String] else {
                return []
        }

        return urlSchemes
    }()

    /// Main Scheme String, could be `nil`
    static var mainScheme: String? = {
        return schemes.first
    }()

    /// if `zh-Hans` is one of the preferred languages
    static var usingChinese: Bool {
        if let l = NSLocale.preferredLanguages.first {
            return l.contains("zh-Hans")
        }
        return false
    }
}

// MARK: - Version Comparison
public extension PlistUtil {

    /// Compare tow version string (eg: `1.0.0`, `2.0.1`, `3.0`)
    ///
    /// - Parameters:
    ///   - lhs: First version string
    ///   - rhs: Second version string
    /// - Returns: Compare result
    static func compare(version lhs: String, with rhs: String) -> ComparisonResult {
        guard !lhs.isEmpty else {
            if rhs.isEmpty {
                return .orderedSame
            }
            return .orderedAscending
        }
        guard !rhs.isEmpty else {
            return .orderedDescending
        }

        return lhs.compare(rhs, options: .numeric, range: rhs.range(of: rhs), locale: nil)
    }

    /// Compare tow version string (eg: `1.0.0`, `2.0.1`, `3.0`)
    ///
    /// - Parameters:
    ///   - lhs: First version string
    ///   - rhs: Second version string
    /// - Returns: If `lhs` is equal to `rhs`
    static func version(_ lhs: String, equalTo rhs: String) -> Bool {
        return compare(version: lhs, with: rhs) == .orderedSame
    }

    /// Compare tow version string (eg: `1.0.0`, `2.0.1`, `3.0`)
    ///
    /// - Parameters:
    ///   - lhs: First version string
    ///   - rhs: Second version string
    /// - Returns: If `lhs` is greater than `rhs`
    static func version(_ lhs: String, greaterThan rhs: String) -> Bool {
        return compare(version: lhs, with: rhs) == .orderedDescending
    }

    /// Compare tow version string (eg: `1.0.0`, `2.0.1`, `3.0`)
    ///
    /// - Parameters:
    ///   - lhs: First version string
    ///   - rhs: Second version string
    /// - Returns: If `lhs` is less than `rhs`
    static func version(_ lhs: String, lessThan rhs: String) -> Bool {
        return compare(version: lhs, with: rhs) == .orderedAscending
    }

    /// Compare tow version string (eg: `1.0.0`, `2.0.1`, `3.0`)
    ///
    /// - Parameters:
    ///   - lhs: First version string
    ///   - rhs: Second version string
    /// - Returns: If `lhs` is greater than or equal to `rhs`
    static func version(_ lhs: String, greaterThanOrEqualTo rhs: String) -> Bool {
        return compare(version: lhs, with: rhs) != .orderedAscending
    }

    /// Compare tow version string (eg: `1.0.0`, `2.0.1`, `3.0`)
    ///
    /// - Parameters:
    ///   - lhs: First version string
    ///   - rhs: Second version string
    /// - Returns: If `lhs` is less than or equal to `rhs`
    static func version(_ lhs: String, lessThanOrEqualTo rhs: String) -> Bool {
        return compare(version: lhs, with: rhs) != .orderedDescending
    }
}

#if os(iOS)
// MARK: - iOS Only
public extension PlistUtil {

    /// UIFileSharingEnabled
    @available(iOS 7.0, *)
    static var iTunesFileSharingEnabled: Bool = {
        return PlistUtil.getBool("UIFileSharingEnabled")
    }()

    /// UIStatusBarHidden
    @available(iOS 7.0, *)
    static var isStatusBarHidden: Bool = {
        return PlistUtil.getBool("UIStatusBarHidden")
    }()

    /// UIStatusBarStyle
    @available(iOS 7.0, *)
    static var statusBarStyleString: String? = {
        return PlistUtil.getString("UIStatusBarStyle")
    }()

    /// UIStatusBarStyle
    @available(iOS 7.0, *)
    static var statusBarStyle: UIStatusBarStyle? = {
        guard let style = PlistUtil.statusBarStyleString else {
            return nil
        }
        switch style {
        case "UIStatusBarStyleDefault":
            return UIStatusBarStyle.default
        case "UIStatusBarStyleLightContent":
            return UIStatusBarStyle.lightContent
        default:
            return nil
        }
    }()

    /// UIViewControllerBasedStatusBarAppearance
    @available(iOS 7.0, *)
    static var viewControllerBasedStatusBarAppearance: Bool = {
        return PlistUtil.getBool("UIViewControllerBasedStatusBarAppearance")
    }()

    /// UISupportedInterfaceOrientations
    @available(iOS 7.0, *)
    static var iPhoneSupportedInterfaceOrientationStrings: [String] = {
        (PlistUtil.getValue("UISupportedInterfaceOrientations") as? [String]) ?? []
    }()

    /// UISupportedInterfaceOrientations
    @available(iOS 7.0, *)
    static var iPhoneSupportedInterfaceOrientations: [UIInterfaceOrientation] = {
        return PlistUtil.supportedInterfaceOrientations(of: PlistUtil.iPhoneSupportedInterfaceOrientationStrings)
    }()

    /// UISupportedInterfaceOrientations~ipad
    @available(iOS 7.0, *)
    static var iPadSupportedInterfaceOrientationStrings: [String] = {
        return (PlistUtil.getValue("UISupportedInterfaceOrientations~ipad") as? [String]) ?? []
    }()

    /// UISupportedInterfaceOrientations~ipad
    @available(iOS 7.0, *)
    static var iPadSupportedInterfaceOrientations: [UIInterfaceOrientation] = {
        return PlistUtil.supportedInterfaceOrientations(of: PlistUtil.iPadSupportedInterfaceOrientationStrings)
    }()

    @available(iOS 7.0, *)
    private static func supportedInterfaceOrientations(of strings: [String]) -> [UIInterfaceOrientation] {
        var orientations = [UIInterfaceOrientation]()
        for str in strings {
            var o = UIInterfaceOrientation.unknown
            switch str {
            case "UIInterfaceOrientationPortrait":
                o = .portrait
                break
            case "UIInterfaceOrientationPortraitUpsideDown":
                o = .portraitUpsideDown
                break
            case "UIInterfaceOrientationLandscapeLeft":
                o = .landscapeLeft
                break
            case "UIInterfaceOrientationLandscapeRight":
                o = .landscapeRight
                break
            default:
                break
            }
            if !orientations.contains(o) {
                orientations.append(o)
            }
        }
        return orientations
    }
}
#endif

// MARK: - iOS 9 or macOS 10.11
public extension PlistUtil {

    /// NSAppTransportSecurity
    @available(iOS 9.0, OSX 10.11, *)
    static var appTransportSecurityConfiguration: [String: Any]? = {
        return PlistUtil.getValue("NSAppTransportSecurity") as? [String: Any]
    }()

    /// NSAllowsArbitraryLoads
    @available(iOS 9.0, OSX 10.11, *)
    static var allowsArbitraryLoads: Bool = {
        guard let infoDictionary = PlistUtil.appTransportSecurityConfiguration else {
            return false
        }
        return (infoDictionary["NSAllowsArbitraryLoads"] as? Bool) ?? false
    }()

    #if os(iOS)
    /// UIRequiresFullScreen
    @available(iOS 9.0, *)
    static var requiresFullScreen: Bool = {
        return PlistUtil.getBool("UIRequiresFullScreen")
    }()
    #endif
}

// MARK: - Privacy
public extension PlistUtil {

    /// Privacy - NSBluetoothPeripheralUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var bluetoothPeripheralUsageDescription: String? = {
        return PlistUtil.getString("NSBluetoothPeripheralUsageDescription")
    }()

    /// Privacy - NSCalendarsUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var calendarsUsageDescription: String? = {
        return PlistUtil.getString("NSCalendarsUsageDescription")
    }()

    /// Privacy - NSCameraUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var cameraUsageDescription: String? = {
        return PlistUtil.getString("NSCameraUsageDescription")
    }()

    /// Privacy - NSContactsUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var contactsUsageDescription: String? = {
        return PlistUtil.getString("NSContactsUsageDescription")
    }()

    /// Privacy - NSHealthShareUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var healthShareUsageDescription: String? = {
        return PlistUtil.getString("NSHealthShareUsageDescription")
    }()

    /// Privacy - NSHealthUpdateUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var healthUpdateUsageDescription: String? = {
        return PlistUtil.getString("NSHealthUpdateUsageDescription")
    }()

    /// Privacy - NSHomeKitUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var homeKitUsageDescription: String? = {
        return PlistUtil.getString("NSHomeKitUsageDescription")
    }()

    /// Privacy - NSLocationAlwaysUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var locationAlwaysUsageDescription: String? = {
        return PlistUtil.getString("NSLocationAlwaysUsageDescription")
    }()

    /// Privacy - NSLocationUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var locationUsageDescription: String? = {
        return PlistUtil.getString("NSLocationUsageDescription")
    }()

    /// Privacy - NSLocationWhenInUseUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var locationWhenInUseUsageDescription: String? = {
        return PlistUtil.getString("NSLocationWhenInUseUsageDescription")
    }()

    /// Privacy - NSAppleMusicUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var appleMusicUsageDescription: String? = {
        return PlistUtil.getString("NSAppleMusicUsageDescription")
    }()

    /// Privacy - NSMicrophoneUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var microphoneUsageDescription: String? = {
        return PlistUtil.getString("NSMicrophoneUsageDescription")
    }()

    /// Privacy - NSMotionUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var motionUsageDescription: String? = {
        return PlistUtil.getString("NSMotionUsageDescription")
    }()

    /// Privacy - NSPhotoLibraryUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var photoLibraryUsageDescription: String? = {
        return PlistUtil.getString("NSPhotoLibraryUsageDescription")
    }()

    /// Privacy - NSRemindersUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var remindersUsageDescription: String? = {
        return PlistUtil.getString("NSRemindersUsageDescription")
    }()

    /// Privacy - NSSiriUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var siriUsageDescription: String? = {
        return PlistUtil.getString("NSSiriUsageDescription")
    }()

    /// Privacy - NSSpeechRecognitionUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var speechRecognitionUsageDescription: String? = {
        return PlistUtil.getString("NSSpeechRecognitionUsageDescription")
    }()

    /// Privacy - NSVideoSubscriberAccountUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    static var videoSubscriberAccountUsageDescription: String? = {
        return PlistUtil.getString("NSVideoSubscriberAccountUsageDescription")
    }()

}
