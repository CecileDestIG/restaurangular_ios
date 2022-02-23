//
//  AllergeneDAO.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 22/02/2022.
//

import Foundation

struct AllergeneDTO : Decodable, Hashable {
    var id_allergene :Int
    var allergene : String
}
