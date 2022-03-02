import SwiftUI

struct EtapeDTO : Codable, Hashable {
    var id_etape : Int?
    var titre_etape : String
    var temps_etape : Double
    var description_etape : String
}

struct EtapeInclusDTO : Codable, Hashable {
    var id_etape : Int
    var titre_etape : String
    var id_recette : Int
    var place_et : Int
    var temps_etape : Double
    var description_etape : String
}

