//
//  Bundle-Decodable.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/06/2022.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let loaded = try decoder.decode(T.self, from: data)
            return loaded
        } catch {
            print(error)
            return [] as! T
        }
    }
}
