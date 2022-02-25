import SwiftUI

class IngredientDAO {
    
    // GET ALL
    
    static func getAllIngredient() async -> [Ingredient]?{
        if let list = await APIRequest.getAll(route: "ingredient", dto: IngredientDTO.self){
            return IngredientDAO.toIngredient(data: list)
        }
        return nil
    }
    
    // Conversion
    
    static func toIngredientInclus(data: [IngredientInclusDTO]) -> [IngredientInclus]?{
          var ingredientInclus_list = [IngredientInclus]()
          for tdata in data{
              let id : Int = tdata.id_ingredient
              let ingredientInclus = IngredientInclus(id, tdata.quantite_necessaire)
             ingredientInclus_list.append(ingredientInclus)
          }
    print("ingredientInclus_list : ",ingredientInclus_list)
    return ingredientInclus_list
    }
    
    static func toIngredient(data: [IngredientDTO]) -> [Ingredient]?{
          var ingredient_list = [Ingredient]()
          for tdata in data{
             guard (tdata.id_ingredient != nil) else{
                 print("Erreur lors de la conversion en ingredient")
                return nil
             }
             let id : Int = tdata.id_ingredient!
              let ingredient = Ingredient(id, tdata.nom_ingredient, tdata.unite, tdata.cout_unitaire, tdata.stock, tdata.id_cat_ingr, tdata.id_allergene ?? -1 , tdata.allergene ?? "Aucun", tdata.nom_ingredient)
             ingredient_list.append(ingredient)
          }
    print("ingredient_list : ",ingredient_list)
    return ingredient_list
    }
}
