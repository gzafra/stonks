//
//  InMemoryDataSource.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation
import Combine

/// Slim in-memory stotage where any Identifiable entity can be added without previous configuration.
///
/// - Parameters:
///   - downstreamScheduler: Publishers' downstream scheduler
///
actor InMemoryDataSorce<
    DownstreamScheduler: Scheduler
>: DataSourceProtocol {

    // MARK: Injected

    private let downstreamScheduler: DownstreamScheduler

    // MARK: State

    private var store = [String: any Subject]()

    // MARK: Lifecycle

    init(
        downstreamScheduler: DownstreamScheduler = DispatchQueue.main
    ) {
        self.downstreamScheduler = downstreamScheduler
    }

    // MARK: LocalDataSource

    nonisolated public func getAllElementsObservable<Entity: Identifiable>(of type: Entity.Type) -> AnyPublisher<[Entity], Never> {
        Future() { promise in
            Task {
                let subject = await self.getSubject(of: Entity.self)
                self.downstreamScheduler.schedule {
                    promise(.success(subject))
                }
            }
        }
        .receive(on: self.downstreamScheduler)
        .flatMap { $0 }
        .eraseToAnyPublisher()
    }

    nonisolated func getSingleElementObervable<Entity: Identifiable>(of type: Entity.Type, with id: Entity.ID) -> AnyPublisher<Entity?, Never> {
        self.getAllElementsObservable(of: Entity.self)
            .map { $0.first { $0.id == id } }
            .eraseToAnyPublisher()
    }

    func getAllElements<Entity: Identifiable>(of type: Entity.Type) async -> [Entity] {
        self.getSubject(of: Entity.self).value
    }

    func getSingleElement<Entity: Identifiable>(of type: Entity.Type, id: Entity.ID) async -> Entity? {
        self.getSubject(of: Entity.self).value
            .first { $0.id == id }
    }

    func add<Entity: Identifiable>(element: Entity) async {
        let subject = self.getSubject(of: Entity.self)
        if (subject.value.contains { $0.id == element.id }) {
            subject.value = subject.value.replacingOcurrences(of: element)
        } else {
            subject.value = subject.value.appending(element)
        }
    }

    func removeAll<Entity: Identifiable>(of type: Entity.Type) async {
        self.getSubject(of: type.self).value = []
    }

    func replaceAll<Entity: Identifiable>(of type: Entity.Type, with elements: [Entity]) async {
        let subject = self.getSubject(of: Entity.self)
        subject.value = elements
    }

    // MARK: Private

    private func getSubject<Entity: Identifiable>(of type: Entity.Type) -> CurrentValueSubject<[Entity], Never> {
        let key = String(describing: type)
        return store[key] as? CurrentValueSubject<[Entity], Never> ?? {
            let newSubject = CurrentValueSubject<[Entity], Never>([])
            self.store[key] = newSubject
            return newSubject
        }()
    }
}
