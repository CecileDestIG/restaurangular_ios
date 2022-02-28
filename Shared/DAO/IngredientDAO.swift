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
             let ingredient = Ingredient(id, tdata.nom_ingredient, tdata.unite, tdata.cout_unitaire, tdata.stock, tdata.id_cat_ingr, tdata.id_allergene ?? -1 , tdata.allergene ?? "Aucun", tdata.nom_cat_ingr ?? "Aucun")
             ingredient_list.append(ingredient)
          }
    print("ingredient_list : ",ingredient_list)
    return ingredient_list
    }
    
    static func createIngredient(ingredient : IngredientVM) async{
        guard let url = URL(string: "https://restaurangularappli.herokuapp.com/ingredient") else {
            print("pb url")
            return
        }
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let encoded = await JSONHelper.encode(data: IngredientDTO(nom_ingredient: ingredient.nom_ingredient, unite: ingredient.unite, cout_unitaire: ingredient.cout_unitaire, stock: ingredient.stock, id_cat_ingr: ingredient.id_cat_ingr, id_allergene: ingredient.id_allergene)) else {
                print("pb encodage")
                return
            }
            let (data, response) = try await URLSession.shared.upload(for:request,from:encoded)
            _ = String(data: data, encoding: .utf8)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode==201 {
                print("requete 201")
            }
            else{
                print("error status")
            }
        }
        catch{
            print("bad request")
        }
    }
    
}
