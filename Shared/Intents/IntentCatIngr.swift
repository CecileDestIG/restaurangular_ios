//
//  IntentCatIngr.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 19/02/2022.
//

import Foundation
import Combine

enum IntentStateCatIngr : CustomStringConvertible, Equatable {
    
    case ready
    case nom_cat_ingrChanging(String)
    case catingrCreation(String)
    
    var description: String {
        switch self{
            case .ready : return "state : .ready"
            case .nom_cat_ingrChanging(let nci) : return "state : .nom_cat_ingr(\(nci))"
            case .catingrCreation(let nci) : return "state : .nom_cat_ingr(\(nci))"
        }
    }
}
    
struct IntentCatIngr {
    private var stateCatIngr = PassthroughSubject<IntentStateCatIngr,Never>()
    
    func addObserver(civm : CatIngrVM){
        self.stateCatIngr.subscribe(civm)
    }
    
    func addObserver(cilvm : CatIngrListVM){
        self.stateCatIngr.subscribe(cilvm)
    }
    
    @MainActor
    func intentToChange(catingr:CatIngrVM) async{
        self.stateCatIngr.send(.nom_cat_ingrChanging(catingr.nom_cat_ingr))
        await CatIngrDAO.modifierCatingr(id_cat_ingr: catingr.getId(), nom_cat_ingr: catingr.nom_cat_ingr)
    }
    
    @MainActor
    func intentToCreate(nom_cat_ingr : String) async {
        await CatIngrDAO.createCatIngr(nom_cat_ingr: nom_cat_ingr)
        self.stateCatIngr.send(.catingrCreation(nom_cat_ingr))
    }
    
    func intentToLoad(cat_ingr_list:CatIngrListVM) async -> [CatIngr]?{
        if let list = await CatIngrDAO.getAllCatIngr(){
            return list.sorted{$0.nom_cat_ingr < $1.nom_cat_ingr}
        }
        else{
            return nil
        }
    }
}

