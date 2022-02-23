import SwiftUI

class IngredientDAO {
    
    static func getAllIngredient() async -> [Ingredient]?{
        if let list = await APIRequest.getAll(route: "ingredient", dto: IngredientDTO.self){
            return IngredientDAO.toIngredient(data: list)
        }
        return nil
    }
    
    static func toIngredient(data: [IngredientDTO]) -> [Ingredient]?{
          var ingredient_list = [Ingredient]()
          for tdata in data{
             guard (tdata.id_ingredient != nil) else{
                 print("Erreur lors de la conversion en ingredient")
                return nil
             }
             let id : Int = tdata.id_ingredient!
             let ingredient = Ingredient(id, tdata.nom_ingredient, tdata.unite, tdata.cout_unitaire, tdata.stock, tdata.id_cat_ingr, tdata.id_allergene, tdata.allergene!, tdata.nom_ingredient)
             ingredient_list.append(ingredient)
          }
    print("ingredient_list : ",ingredient_list)
    return ingredient_list
    }
}
