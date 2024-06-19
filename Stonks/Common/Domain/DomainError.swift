//
//  DomainError.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation

enum DomainError: Error {
    case httpClient(underlying: HTTPClientError)
    case generic
}
