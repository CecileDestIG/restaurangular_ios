import SwiftUI

struct IngredientDTO : Codable, Hashable {
    var id_ingredient : Int?
    var nom_ingredient : String
    var unite : String
    var cout_unitaire : Double
    var stock : Double

    var id_cat_ingr : Int
    var nom_cat_ingr : String?
    var id_allergene : Int
    var nom_allergene : String?
    
    static func toIngredient(data: [IngredientDTO]) -> [Ingredient]?{
          var ingredient_list = [Ingredient]()
          for tdata in data{
             guard (tdata.id_ingredient != nil) else{
                return nil
             }
             let id : Int = tdata.id_ingredient ?? tdata.id_ingredient!
             let nomCatIngr = tdata.nom_cat_ingr ?? ""
             let nomAllergene = tdata.nom_allergene ?? ""
              let ingredient = Ingredient(id_ingredient: id, nom_ingredient: tdata.nom_ingredient, unite: tdata.unite, cout_unitaire: tdata.cout_unitaire, stock: tdata.stock, id_cat_ingr: tdata.id_cat_ingr, id_allergene: tdata.id_allergene, allergene: nomAllergene, nom_cat_ingr: nomCatIngr)
             ingredient_list.append(ingredient)
          }
    return ingredient_list
    }

}
