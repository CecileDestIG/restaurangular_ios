//
//  JSONHelper.swift
//  02-ListAsync
//
//  Created by Christophe Fiorio on 28/01/2022.
//

import Foundation


struct JSONHelper{
   
   static func decode<T: Decodable>(data: Data) async -> T?{
      let decoder = JSONDecoder()
      guard let decoded = try? decoder.decode(T.self, from: data) else {
         return nil
      }
      return decoded
   }
   static func encode<T: Encodable>(data: T) async -> Data?{
      let encoder = JSONEncoder()
      return try? encoder.encode(data)
   }
}
