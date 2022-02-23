
import SwiftUI

class CatIngrDAO {
    
    static func getAllCatIngr() async -> [CatIngr]?{
        if let list = await APIRequest.getAll(route: "cat_ingr", dto: CatIngrDTO.self){
            return CatIngrDAO.toCatIngr(data: list)
        }
        return nil
    }
    
    static func toCatIngr(data: [CatIngrDTO]) -> [CatIngr]?{
          var cat_ingr_list = [CatIngr]()
          for tdata in data{
             guard (tdata.id_cat_ingr != nil) else{
                return nil
             }
             let id : Int = tdata.id_cat_ingr ?? tdata.id_cat_ingr!
             let cat_ingr = CatIngr(id, tdata.nom_cat_ingr)
             cat_ingr_list.append(cat_ingr)
          }
    return cat_ingr_list
    }
}
