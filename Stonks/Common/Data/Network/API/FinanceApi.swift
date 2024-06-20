//
//  FinanceApi.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation

struct FinanceApi: ApiDefinitionProtocol {
    enum Endpoint: EndpointProtocol {
        case quote

        var path: String {
            switch self {
            case .quote:
                return "/v6/finance/quote"
            }
        }
    }

    var endpoint: EndpointProtocol
    var baseURL: String = "https://yfapi.net"
}
