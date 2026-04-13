//
//  Task+Extensions.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 24/03/26.
//

import Combine

extension Task {
    func store(in set: inout Set<AnyCancellable>) {
        set.insert(AnyCancellable(cancel))
    }
}
