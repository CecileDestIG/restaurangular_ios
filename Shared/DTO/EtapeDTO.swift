import SwiftUI

struct EtapeDTO : Codable, Hashable {
    var id_etape : Int?
    var titre_etape : String
    var temps_etape : Double
    var description_etape : String
}

