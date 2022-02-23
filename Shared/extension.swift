//
//  extension.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 22/02/2022.
//

import Foundation

extension URLSession {
    func getJSON<T:Decodable>(from url : URL) async throws -> T {
        let (data, _)=try await data(from:url)
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(T.self, from:data)
        return decoded
    }
    
}
