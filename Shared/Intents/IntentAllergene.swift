//
//  IntentAllergene.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 19/02/2022.
//

import Foundation
import Combine

enum IntentStateAllergene : CustomStringConvertible, Equatable {
    
    case ready
    case nom_allergeneChanging(String)
   /* case loading(String)
    case loaded*/
    
    var description: String {
        switch self{
            case .ready : return "state : .ready"
            case .nom_allergeneChanging(let na) : return "state : .nom_allergene(\(na))"
            /*case .loading(let na) : return "state : \(na)"
            case .loaded : return "state : loaded"*/

        }
    }
}
    
struct IntentAllergene {
    private var stateAllergene = PassthroughSubject<IntentStateAllergene,Never>()
    
    func addObserver(avm : AllergeneVM){
        self.stateAllergene.subscribe(avm)
    }
    
    func addObserver(alvm : AllergeneListVM){
        self.stateAllergene.subscribe(alvm)
    }
    
    func intentToChange(nom_allergene:String){
        self.stateAllergene.send(.nom_allergeneChanging(nom_allergene))
    }
    
    func intentToLoad(){
        
    }
}

