import SwiftUI

struct CatIngrDTO {
    var id_cat_ingr : Int?
    var nom_cat_ingr : String
}

struct GoRestCatIngrDTO : Codable, Hashable {
    var data : [CatIngrDTO]
}

struct GoRestCatIngrResponse : Decodable {
    var data : CatIngrDTO
}