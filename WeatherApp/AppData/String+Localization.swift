//
//  String+Localization.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import Foundation

class BundleClass {}

extension String {
    public var localized: String {
        var result =
            Bundle(for: BundleClass.self).localizedString(forKey: self, value: nil, table: nil)
        
        //Look into the CustomLocalizable file for a value there
        let customLocalizable = Bundle.main.localizedString(forKey: self, value: nil, table: "CustomLocalizable")
        if customLocalizable != self {
            result = customLocalizable
        }
        let languageCode = Locale.preferredLanguage //en-US
        
        var path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        
        if path == nil, let hyphenRange = languageCode.range(of: "-") {
            let languageCodeShort = String(languageCode[..<hyphenRange.lowerBound]) // en
            path = Bundle.main.path(forResource: languageCodeShort, ofType: "lproj")
        }
        
        if let path = path, let locBundle = Bundle(path: path) {
            result = locBundle.localizedString(forKey: self, value: nil, table: nil)
        } else {
            result = NSLocalizedString(self, comment: "")
        }
        return result
    }
}
extension Locale {
    static var preferredLanguage: String {
        get {
            return self.preferredLanguages.first ?? "en"
        }
    }
}

public struct LocalizedString {
    public struct General {
        public static let generic = "Generic_Message".localized
    }
}
