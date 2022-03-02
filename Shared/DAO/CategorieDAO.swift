
import SwiftUI

class CategorieDAO {
    
    // GET ALL
    
    static func getAllCategorie() async -> [Categorie]?{
        if let list = await APIRequest.getAll(route: "categorie", dto: CategorieDTO.self){
            return CategorieDAO.toCategorie(data: list)
        }
        return nil
    }
    
    //GET
    
    static func getCategorie(id_categorie : Int) async -> Categorie?{
        if let categorie = await APIRequest.get(route: "categorie/"+"\(id_categorie)", dto: CategorieDTO.self){
            return CategorieDAO.toCategorie(data: categorie)
        }
        return nil
    }
    
    static func toCategorie(data: CategorieDTO) -> Categorie?{
        return Categorie(data.id_categorie ,data.nom_categorie)
    }
    
    
    static func toCategorie(data: [CategorieDTO]) -> [Categorie]?{
          var categories = [Categorie]()
          for tdata in data{
              let categorie = Categorie(tdata.id_categorie, tdata.nom_categorie)
             categories.append(categorie)
          }
    return categories
    }
    
    static func createCategorie(nom_categorie : String) async{
        guard let url = URL(string: "https://restaurangularappli.herokuapp.com/categorie") else {
            print("pb url")
            return
        }
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let encoded = await JSONHelper.encode(data: CategorieDTO(id_categorie: 0, nom_categorie: nom_categorie)) else {
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
    
    static func modifierCategorie( id_categorie:Int, nom_categorie : String) async{
        guard let url = URL(string: "https://restaurangularappli.herokuapp.com/categorie/\(id_categorie)") else {
            print("pb url")
            return
        }
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let encoded = await JSONHelper.encode(data: CategorieDTO(id_categorie: id_categorie, nom_categorie: nom_categorie)) else {
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
