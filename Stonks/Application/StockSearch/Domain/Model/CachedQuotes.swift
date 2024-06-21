//
//  CachedQuotes.swift
//  Stonks
//
//  Created by Guillermo Zafra on 21/6/24.
//

import Foundation

struct CachedQuotes: Identifiable {
    let id: String
    let savedTime: TimeInterval
    let quotesResult: [Quote]
}
