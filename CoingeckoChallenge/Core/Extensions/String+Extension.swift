//
//  String+Extension.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 12/04/26.
//

import Foundation

extension String {
    var htmlStripped: String {
        return self.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression,
            range: nil
        )
    }
    
    var localized: String {
        let value = NSLocalizedString(self, comment: "")
        if value != self || NSLocale.preferredLanguages.first == "en" {
            return value
        }
        
        guard
            let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
            let bundle = Bundle(path: path)
        else { return value }
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }

    func localized(with arguments: CVarArg...) -> String {
        String.localizedStringWithFormat(self.localized, arguments)
    }
}
