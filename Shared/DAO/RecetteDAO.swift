//
//  RecetteDAO.swift
//  Restaurangular
//
//  Created by m1 on 22/02/2022.
//

import Foundation

class RecetteDAO {
    
    // GET ALL
    
    static func getAllRecette() async -> [Recette]?{
        if let list = await APIRequest.getAll(route: "recette", dto: RecetteDTO.self){
            return RecetteDAO.toRecette(data: list)
        }
        return nil
    }
    
    // Conversion
    
    static func toRecetteInclus(data: [RecetteInclusDTO]) -> [RecetteInclus]?{
          var recetteInclus_list = [RecetteInclus]()
          for tdata in data{
             let id : Int = tdata.id_recincl
              let recetteInclus = RecetteInclus(id, tdata.place_rec)
             recetteInclus_list.append(recetteInclus)
          }
    //print("recetteInclus_list : ",recetteInclus_list)
    return recetteInclus_list
    }
    
    static func toRecette(data: [RecetteDTO]) -> [Recette]?{
          var recette_list = [Recette]()
          for tdata in data{
              guard (tdata.r[0].id_recette != nil) else{
                 print("Erreur lors de la conversion en ingredient")
                return nil
             }
              let id : Int = tdata.r[0].id_recette!
              var etapetmp : [EtapeInclus]? = nil
              var recettetmp : [RecetteInclus]? = nil
              if let etapes = tdata.etapes {
                  etapetmp = EtapeDAO.toEtapeInclus(data: etapes)
              }
              if let recettes = tdata.recinclus {
                  recettetmp = RecetteDAO.toRecetteInclus(data: recettes)
              }
              let ingredienttmp = IngredientDAO.toIngredientInclus(data: tdata.ingredients)
              let recette = Recette(id, tdata.r[0].id_createur, tdata.r[0].nom_recette, tdata.r[0].nb_couvert, tdata.r[0].id_categorie,tdata.r[0].nom_categorie,tdata.r[0].prix_vente,etapetmp , recettetmp, ingredienttmp,tdata.r[0].image ?? "")
              recette_list.append(recette)
          }
    //print("recette_list : ",recette_list)
    return recette_list
    }
    
    static func createRecette(recette : RecetteVM, recincl:[RecetteInclusCreateDTO]?, etincl:[EtapeCreateRecetteDTO], ingredients:[IngredientCreateRecetteDTO]) async{
        guard let url = URL(string: "https://restaurangularappli.herokuapp.com/recette") else {
            print("pb url")
            return
        }
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            if (recincl==nil){
                guard let encoded = await JSONHelper.encode(data: RecetteCreateSansDTO(id_createur: 1, nom_recette: recette.nom_recette, nb_couvert: recette.nb_couvert, id_categorie: recette.id_categorie, prix_vente: recette.prix_vente, temps_recette: recette.tempsRecette(), cout_production: recette.coutProduction(coutMatiere: recette.coutMatiere(), coutCharge: recette.coutCharge()), nom_createur: "user", ingredients: ingredients, recinclus: "rien", etapes: etincl)) else {
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
            else{
                guard let encoded = await JSONHelper.encode(data: RecetteCreateDTO(id_createur: 1, nom_recette: recette.nom_recette, nb_couvert: recette.nb_couvert, id_categorie: recette.id_categorie, prix_vente: recette.prix_vente, temps_recette: recette.tempsRecette(), cout_production: recette.coutProduction(coutMatiere: recette.coutMatiere(), coutCharge: recette.coutCharge()), nom_createur: "user", ingredients: ingredients, recinclus: recincl!, etapes: etincl)) else {
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
            
        }
        catch{
            print("bad request create recette")
        }
    }
    
    @MainActor
    static func deleteRecette(id:Int) async{
        guard let url = URL(string: "https://restaurangularappli.herokuapp.com/recette/\(id)") else {
            print("pb url")
            return
        }
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            let task = URLSession.shared.dataTask(with: request)
            {
              (data, response, error) in
              guard let _ = data else {
                print("error calling DELETE on /todos/1")
                return
              }
              print("DELETE ok")
            }
            task.resume()
    }




static func modifyRecette(recette : RecetteVM, recincl:[RecetteInclusCreateDTO]?, etincl:[EtapeCreateRecetteDTO], ingredients:[IngredientCreateRecetteDTO]) async{
    guard let url = URL(string: "https://restaurangularappli.herokuapp.com/recette/\(recette.getId())") else {
        print("pb url")
        return
    }
    do{
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if (recincl==nil){
            guard let encoded = await JSONHelper.encode(data: RecetteCreateSansDTO(id_createur: 1, nom_recette: recette.nom_recette, nb_couvert: recette.nb_couvert, id_categorie: recette.id_categorie, prix_vente: recette.prix_vente, temps_recette: recette.tempsRecette(), cout_production: 0, nom_createur: "user", ingredients: ingredients, recinclus: "rien", etapes: etincl)) else {
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
        else{
            guard let encoded = await JSONHelper.encode(data: RecetteCreateDTO(id_createur: 1, nom_recette: recette.nom_recette, nb_couvert: recette.nb_couvert, id_categorie: recette.id_categorie, prix_vente: recette.prix_vente, temps_recette: recette.tempsRecette(), cout_production: 0, nom_createur: "user", ingredients: ingredients, recinclus: recincl!, etapes: etincl)) else {
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
        
    }
    catch{
        print("bad request create recette")
    }
}

}
