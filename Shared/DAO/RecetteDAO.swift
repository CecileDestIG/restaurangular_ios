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
        if let list = await APIRequest.getAll(route: "recette", dto: RecettesDTO.self){
            return RecetteDAO.toRecette(data: list)
        }
        return nil
    }
    
    //GET
    
    static func getRecette(id_recette : Int) async -> Recette?{
        if let recette = await APIRequest.get(route: "recette/"+"\(id_recette)", dto:RecetteDTO.self){
            return RecetteDAO.toRecette(data: recette)
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
    print("recetteInclus_list : ",recetteInclus_list)
    return recetteInclus_list
    }
    
    static func toRecette(data: RecetteDTO) -> Recette?{
        guard (data.data.id_recette != nil) else{
            print("Erreur lors de la conversion en recette")
        return nil
        }
        let id : Int = data.data.id_recette!
        var etapetmp : [EtapeInclus]? = nil
        var recettetmp : [RecetteInclus]? = nil
        if let etapes = data.etapes {
            etapetmp = EtapeDAO.toEtapeInclus(data: etapes)
        }
        if let recettes = data.recinclus {
            recettetmp = RecetteDAO.toRecetteInclus(data: recettes)
        }
        let ingredienttmp = IngredientDAO.toIngredientInclus(data: data.ingredients)
        let recette = Recette(id, data.data.id_createur, data.data.nom_recette, data.data.nb_couvert, data.data.id_categorie, data.data.prix_vente,etapetmp , recettetmp, ingredienttmp)
        print("recette_list : ",recette)
        return recette
    }
    
    static func toRecette(data: [RecettesDTO]) -> [Recette]?{
          var recette_list = [Recette]()
          for tdata in data{
             guard (tdata.id_recette != nil) else{
                 print("Erreur lors de la conversion en ingredient")
                return nil
             }
             let id : Int = tdata.id_recette!
              let recette = Recette(id, tdata.id_createur, tdata.nom_recette, tdata.nb_couvert, tdata.id_categorie, tdata.prix_vente, nil, nil, nil)
             recette_list.append(recette)
          }
    print("recette_list : ",recette_list)
    return recette_list
    }
}
