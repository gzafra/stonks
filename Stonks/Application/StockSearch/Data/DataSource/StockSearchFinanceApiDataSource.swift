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
        let request = httpClient.GET(apiDefinition)

        return httpClient.execute(request, mapTo: StockSearchApiResponse.self).mapError { (apiError) -> DomainError in
            // TODO: This mapping should be done by an error handler
            return DomainError.httpClient(underlying: apiError)
        }.map { apiResponse -> [Quote] in
            return self.mapper.mapObjects(from: apiResponse.quoteResponse.result)
        }.eraseToAnyPublisher()
    }
}
