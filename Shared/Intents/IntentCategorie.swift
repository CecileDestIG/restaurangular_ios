//
//  IntentCategorie.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 02/03/2022.
//

import Foundation
import Combine

enum IntentStateCategorie : CustomStringConvertible, Equatable {
    
    case ready
    case nom_categorieChanging(String)
    case categorieCreation(String)
    
    var description: String {
        switch self{
            case .ready : return "state : .ready"
            case .nom_categorieChanging(let nc) : return "state : .nom_categorie(\(nc))"
            case .categorieCreation(let nc) : return "state : .nom_categorie(\(nc))"
        }
    }
}
    
struct IntentCategorie {
    private var stateCategorie = PassthroughSubject<IntentStateCategorie,Never>()
    
    func addObserver(cvm : CategorieVM){
        self.stateCategorie.subscribe(cvm)
    }
    
    func addObserver(clvm : CategorieListVM){
        self.stateCategorie.subscribe(clvm)
    }
    
    func intentToChange(categorie:CategorieVM) async{
        self.stateCategorie.send(.nom_categorieChanging(categorie.nom_categorie))
        await CategorieDAO.modifierCategorie(id_categorie: categorie.getId(), nom_categorie: categorie.nom_categorie)
    }
    
    @MainActor
    func intentToCreate(nom_categorie : String) async {
        await CategorieDAO.createCategorie(nom_categorie: nom_categorie)
        self.stateCategorie.send(.categorieCreation(nom_categorie))
    }
}
