//
//  CacheDataSource.swift
//  Stonks
//
//  Created by Guillermo Zafra on 25/6/24.
//

import Foundation
import Combine

enum CacheError: Error {
    case invalidPath
    case writingFailed
}

fileprivate enum Default {
    static let key = "Shared"
    static let cacheName = "Default"
}


protocol CacheDataSourceProtocol {
    @discardableResult
    func cache<T: Codable>(_ value: T, with key: String) -> Result<Void, CacheError>
    func getCache<T: Codable>(for key: String) -> T?
}

final class CacheDataSource: CacheDataSourceProtocol {
    private let directory: URL?
    private let cacheName: String
    private let fileManager: FileManager
    
    init(cacheName: String = Default.cacheName, 
         directory: URL? = Defaults.defaultDirectory,
         fileManager: FileManager = Defaults.defaultFileManager) {
        self.cacheName = cacheName
        self.directory = directory
        self.fileManager = fileManager
    }

    // MARK: - Cache API
    
    /// Caches a Codable object for a given key
    @discardableResult
    func cache<Entity: Codable>(_ value: Entity, with key: String) -> Result<Void, CacheError> {
        do {
            let data = try JSONEncoder().encode(value)
            guard let directory = self.directory else { throw CacheError.invalidPath }
            let path = directory.appendingPathComponent(self.cacheName)
            try self.fileManager.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
            try data.write(to: path.appendingPathComponent(key), options: [.atomic])
            return .success(())
        } catch {
            print("Error caching: \(error.localizedDescription)")
            return .failure(CacheError.writingFailed)
        }
    }
    
    /// Retrieves the Codable object from cache, nil if empty
    func getCache<Entity: Codable>(for key: String = Default.key) -> Entity? {
        do {
            guard let directory = self.directory else { throw CacheError.invalidPath }
            let filename = directory.appendingPathComponent(self.cacheName).appendingPathComponent(key)
            guard let value = try? Data(contentsOf: filename) else {
                return nil
            }
            do {
                let decoded = try JSONDecoder().decode(Entity.self, from: value as Data)
                return decoded
            } catch {
                print("Error decoding: \(error.localizedDescription)")
                self.deleteCache() // Clear cache if decoding fails
                return nil
            }
        } catch {
            return nil
        }
    }
    
    /// Deletes the cache directory
    func deleteCache() {
        guard let filename = directory?.appendingPathComponent(cacheName) else { return }
        try? fileManager.removeItem(at: filename)
    }
}


// MARK: - Defaults
fileprivate enum Defaults {
    static var defaultDirectory: URL? {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        guard paths.count > 0 else { return nil }
        return paths[0]
    }
    
    static var defaultFileManager: FileManager = {
        let instance = FileManager()
        return instance
    }()
}
