import SwiftUI

class CatIngrDAO {
    
    static func getAllCatIngr() async -> [CatIngr]?{
        if let list = await APIRequest.getAll(route: "cat_ingr", dto: CatIngrDTO.self){
            return CatIngrDTO.toCatIngr(data: list)
        }
        return nil
    }
}
