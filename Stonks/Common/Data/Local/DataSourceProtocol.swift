//
//  LocalDataSourceProtocol.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//
import Combine

protocol DataSourceProtocol {
    func getAllElementsObservable<Entity: Identifiable>(of type: Entity.Type) -> AnyPublisher<[Entity], Never>
    func getSingleElementObervable<Entity: Identifiable>(of type: Entity.Type, with id: Entity.ID) -> AnyPublisher<Entity?, Never>
    func getSingleElement<Entity: Identifiable>(of type: Entity.Type, id: Entity.ID) async -> Entity?
    func add<Entity: Identifiable>(element: Entity) async
    func removeAll<Entity: Identifiable>(of type: Entity.Type) async
    func replaceAll<Entity: Identifiable>(of type: Entity.Type, with elements: [Entity]) async
}
