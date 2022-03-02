import SwiftUI

struct CatIngrDTO : Codable, Hashable {
    var id_cat_ingr : Int?
    var nom_cat_ingr : String
}

struct CategorieDTO : Codable, Hashable {
    var id_categorie : Int
    var nom_categorie : String
}
