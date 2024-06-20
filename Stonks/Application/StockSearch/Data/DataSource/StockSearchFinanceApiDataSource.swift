//
//  StockSearchFinanceApiDataSource.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation
import Combine

struct StockSearchFinanceApiDataSource: StockSearchDataSourceProtocol {
    let httpClient: HTTPClient
    let mapper = QuoteApiMapper()

    func getQuote(ticker: String) -> AnyPublisher<[Quote], DomainError> {
        let apiDefinition = FinanceApi(endpoint: FinanceApi.Endpoint.quote)
        var request = DefaultHTTPRequest(method: .get, apiDefinition: apiDefinition)
        request.urlParameters = ["region": "US", "lang": "en", "symbols": ticker]
        request.headers = ["x-api-key":"8MSFcNxumlkJjsfo1sZq3p3AMgMUfE9aR489sj36"]
        
        return httpClient.execute(request, mapTo: StockSearchApiResponse.self).mapError { (apiError) -> DomainError in
            // TODO: This mapping should be done by an error handler
            return DomainError.httpClient(underlying: apiError)
        }.map { apiResponse -> [Quote] in
            return self.mapper.mapObjects(from: apiResponse.quoteResponse.result)
        }.eraseToAnyPublisher()
    }
}
