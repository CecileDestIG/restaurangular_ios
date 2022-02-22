import SwiftUI

struct IngredientDTO {
    var id_ingredient : Int?
    var nom_ingredient : String
    var unite : String
    var cout_unitaire : Double
    var stock : Double

    var id_cat_ingr : Int
    var nom_cat_ingr : String?
    var id_allergene : Int
    var nom_allergene : String?

}

struct GoRestIngredientDTO : Codable, Hashable {
    var data : [IngredientDTO]
}

struct GoRestIngredientResponse : Decodable {
    var data : IngredientDTO
}