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
              let recette = Recette(id, tdata.r[0].id_createur, tdata.r[0].nom_recette, tdata.r[0].nb_couvert, tdata.r[0].id_categorie,tdata.r[0].nom_categorie,tdata.r[0].prix_vente,etapetmp , recettetmp, ingredienttmp)
              recette_list.append(recette)
          }
    //print("recette_list : ",recette_list)
    return recette_list
    }
}
