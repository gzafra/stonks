//
//  InMemoryDataSource.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation

protocol InMemoryDataSourceProtocol {
    func getAllElements<Entity: Identifiable>(of type: Entity.Type) -> [Entity]
    func getSingleElement<Entity: Identifiable>(of type: Entity.Type, with id: Entity.ID) -> Entity?
    func add<Entity: Identifiable>(element: Entity)
    func add<Entity: Identifiable>(elements: [Entity])
    func removeAll<Entity: Identifiable>(of type: Entity.Type)
    func replaceAll<Entity: Identifiable>(of type: Entity.Type, with elements: [Entity])
}

final class InMemoryDataSource: InMemoryDataSourceProtocol {

    private var store = [String: [any Identifiable]]()

    // MARK: Public

    func getAllElements<Entity: Identifiable>(of type: Entity.Type) -> [Entity] {
        getItems(of: Entity.self)
    }

    func getSingleElement<Entity: Identifiable>(of type: Entity.Type, with id: Entity.ID) -> Entity? {
        getItems(of: Entity.self)
            .first { $0.id == id }
    }
    
    func add<Entity: Identifiable>(elements: [Entity]) {
        elements.forEach { element in
            self.add(element: element)
        }
    }

    func add<Entity: Identifiable>(element: Entity) {
        let key = String(describing: Entity.self)
        var items = getItems(of: Entity.self)
        if (items.contains { $0.id == element.id }) {
            store[key] = items.replacingOcurrences(of: element)
        } else {
            store[key] = items.appending(element)
        }
    }

    func removeAll<Entity: Identifiable>(of type: Entity.Type) {
        let key = String(describing: type)
        store.removeValue(forKey: key)
    }

    func replaceAll<Entity: Identifiable>(of type: Entity.Type, with elements: [Entity]) {
        let key = String(describing: type)
        store[key] = elements
    }

    // MARK: Private

    private func getItems<Entity: Identifiable>(of type: Entity.Type) -> [Entity] {
        let key = String(describing: type)
        return store[key] as? [Entity] ?? {
            let newSubject = [Entity]()
            self.store[key] = newSubject
            return newSubject
        }()
    }
}
