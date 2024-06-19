import Foundation

protocol EndpointProtocol {
    var path: String { get }
}

protocol ApiDefinitionProtocol {
    var endpoint: EndpointProtocol { get }
    var baseURL: String { get }
}
