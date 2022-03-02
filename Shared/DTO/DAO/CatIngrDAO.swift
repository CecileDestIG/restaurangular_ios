//
//  CatIngrDAO.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 02/03/2022.
//

import Foundation

class CatIngrDAO {
    
    // GET ALL
    
    static func getAllCatIngr() async -> [CatIngr]?{
        if let list = await APIRequest.getAll(route: "cat_ingr", dto: CatIngrDTO.self){
            return CatIngrDAO.toCatIngr(data: list)
        }
        return nil
    }
    
    //GET
    
    static func getCatIngr(id_cat_ingr : Int) async -> CatIngr?{
        if let catingr = await APIRequest.get(route: "cat_ingr/"+"\(id_cat_ingr)", dto: CatIngrDTO.self){
            return CatIngrDAO.toCatIngr(data: catingr)
        }
        return nil
    }
    
    static func toCatIngr(data: CatIngrDTO) -> CatIngr?{
        return CatIngr(data.id_cat_ingr ?? 0,data.nom_cat_ingr)
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
    
    static func createCatIngr(nom_cat_ingr : String) async{
        guard let url = URL(string: "https://restaurangularappli.herokuapp.com/cat_ingr") else {
            print("pb url")
            return
        }
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let encoded = await JSONHelper.encode(data: CatIngrDTO(nom_cat_ingr: nom_cat_ingr)) else {
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
    
    static func modifierCatingr( id_cat_ingr:Int, nom_cat_ingr : String) async{
        guard let url = URL(string: "https://restaurangularappli.herokuapp.com/cat_ingr/\(id_cat_ingr)") else {
            print("pb url")
            return
        }
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let encoded = await JSONHelper.encode(data: CatIngrDTO(nom_cat_ingr: nom_cat_ingr)) else {
                print("pb encodage")
                return
            }
            let (data, response) = try await URLSession.shared.upload(for:request,from:encoded)
            let sdata = String(data: data, encoding: .utf8)
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
