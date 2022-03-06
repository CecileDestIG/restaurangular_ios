import SwiftUI

struct IngredientDTO : Codable, Hashable {
    var id_ingredient : Int?
    var nom_ingredient : String
    var unite : String
    var cout_unitaire : Double
    var stock : Double
    var id_cat_ingr : Int
    var nom_cat_ingr : String?
    var id_allergene : Int?
    var allergene : String?
    var image : String?
}

struct IngredientInclusDTO : Codable, Hashable {
    var id_ingredient : Int
    var nom_ingredient : String
    var unite : String
    var cout_unitaire : Double
    var stock : Double
    var id_allergene : Int?
    var allergene : String?
    var id_cat_ingr : Int
    var nom_cat_ingr : String
    var id_recette : Int
    var quantite_necessaire : Double
}

struct IngredientCreateRecetteDTO : Codable, Hashable {
    var id_ingredient : Int
    var quantite_necessaire : Double
}
