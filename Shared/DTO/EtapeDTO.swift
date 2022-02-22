import SwiftUI

struct EtapeDTO {
    var id_etape : Int?
    var titre_etape : String
    var temps_etape : Double
    var description_etape : String
}

struct GoRestEtapeDTO : Codable, Hashable {
    var data : [EtapeDTO]
}

struct GoRestEtapeResponse : Decodable {
    var data : EtapeDTO
}