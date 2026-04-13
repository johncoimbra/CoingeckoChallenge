//
//  Date+Extension.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 12/04/26.
//

import Foundation

extension Date {
    func toRelativeString() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
