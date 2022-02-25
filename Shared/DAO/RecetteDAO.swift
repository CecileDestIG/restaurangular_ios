//
//  RecetteDAO.swift
//  Restaurangular
//
//  Created by m1 on 22/02/2022.
//

import Foundation

class RecetteDAO {
    
    static func getAllRecette() async -> [Recette]?{
        if let list = await APIRequest.getAll(route: "recette", dto: RecettesDTO.self){
            return RecetteDAO.toRecette(data: list)
        }
        return nil
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
