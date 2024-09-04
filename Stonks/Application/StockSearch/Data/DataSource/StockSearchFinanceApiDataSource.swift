//
//  StockSearchFinanceApiDataSource.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation
import Combine

struct StockSearchFinanceApiDataSource: StockSearchDataSourceProtocol {
    private enum Constants {
        static let apiKey = "API_KEY"
        static let defaultRegion = "US"
        static let defaultLanguage = "en"
        
        enum Keys {
            static let apiKey = "x-api-key"
            static let region = "region"
            static let language = "lang"
        }
    }
    let httpClient: HTTPClient
    let configDataSource: ConfigDataSourceProtocol
    let mapper = QuoteApiMapper()

    func getQuote(ticker: String) -> AnyPublisher<[Quote], DomainError> {
        let apiDefinition = FinanceApi(endpoint: FinanceApi.Endpoint.quote)
        guard let apiKey: String = configDataSource.loadValue(forKey: Constants.apiKey) else {
            return Fail(error: DomainError.missingApiKey).eraseToAnyPublisher()
        }
        var request = DefaultHTTPRequest(method: .get, apiDefinition: apiDefinition)
        request.urlParameters = [Constants.Keys.region: Constants.defaultRegion,
                                 Constants.Keys.language: Constants.defaultLanguage,
                                 "symbols": ticker]
        request.headers = [Constants.Keys.apiKey: apiKey]
        
        return httpClient.execute(request, mapTo: StockSearchApiResponse.self).mapError { (apiError) -> DomainError in
            // TODO: This mapping should be done by an error handler
            return DomainError.httpClient(underlying: apiError)
        }.map { apiResponse -> [Quote] in
            return self.mapper.mapObjects(from: apiResponse.quoteResponse.result)
        }.eraseToAnyPublisher()
    }
}
