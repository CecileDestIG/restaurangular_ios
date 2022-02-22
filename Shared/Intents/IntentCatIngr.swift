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
    
    var description: String {
        switch self{
            case .ready : return "state : .ready"
            case .nom_cat_ingrChanging(let nci) : return "state : .nom_cat_ingr(\(nci))"
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
    
    func intentToChange(nom_cat_ingr:String){
        self.stateCatIngr.send(.nom_cat_ingrChanging(nom_cat_ingr))
    }
}

