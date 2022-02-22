import SwiftUI

struct RecetteDTO {
    var id_recette : Int?
    var nom_recette : String
}

struct GoRestRecetteDTO : Codable, Hashable {
    var data : [RecetteDTO]
}

struct GoRestRecetteResponse : Decodable {
    var data : RecetteDTO
}