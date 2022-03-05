//
//  JSONHelper.swift
//  Restaurangular
//
//  Created by m1 on 22/02/2022.
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

