//
//  HTTPCode.swift
//  Courses
//
//  Created by Guillermo Zafra on 5/7/22.
//  Copyright © 2022 Guillermo Zafra. All rights reserved.
//

import Foundation

struct HTTPCode {
    var code: Int

    /// Informational - Request received, continuing process.
    public var isInformational: Bool {
        return isIn(range: 100...199)
    }
    /// Success - The action was successfully received, understood, and accepted.
    public var isSuccess: Bool {
        return isIn(range: 200...299)
    }
    /// Redirection - Further action must be taken in order to complete the request.
    public var isRedirection: Bool {
        return isIn(range: 300...399)
    }
    /// Client Error - The request contains bad syntax or cannot be fulfilled.
    public var isClientError: Bool {
        return isIn(range: 400...499)
    }
    /// Server Error - The server failed to fulfill an apparently valid request.
    public var isServerError: Bool {
        return isIn(range: 500...599)
    }
}

fileprivate extension HTTPCode {
    private func isIn(range: ClosedRange<Int>) -> Bool {
        return range.contains(code)
    }
}
