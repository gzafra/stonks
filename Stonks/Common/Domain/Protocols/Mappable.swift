//
//  Mappable.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation

protocol Mappable {
    associatedtype FromType
    associatedtype ToType

    func mapObject(from objectToMap: FromType) -> ToType
    func mapObject(fromOptional objectToMap: FromType?) -> ToType?
    func mapObjects(from objectsToMap: [FromType]) -> [ToType]
}

extension Mappable {
    func mapObject(fromOptional objectToMap: FromType?) -> ToType? {
        guard let unwrapped = objectToMap else {
            return nil
        }

        let returnValue: ToType = mapObject(from: unwrapped)
        return returnValue
    }

    func mapObjects(from objectsToMap: [FromType]) -> [ToType] {
        return objectsToMap.map { self.mapObject(from: $0) }
    }
}
