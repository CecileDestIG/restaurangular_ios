import SwiftUI

struct AllergeneDTO {
    var id_allergene : Int?
    var nom_allergene : String
}

struct GoRestAllergeneDTO : Codable, Hashable {
    var data : [AllergeneDTO]
}

struct GoRestAllergeneResponse : Decodable {
    var data : AllergeneDTO
}