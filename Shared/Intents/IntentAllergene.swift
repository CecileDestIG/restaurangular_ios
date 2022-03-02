//
//  IntentAllergene.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 19/02/2022.
//

import Foundation
import Combine

enum IntentStateAllergene : CustomStringConvertible, Equatable {
    
    case ready
    case nom_allergeneChanging(String)
    case allergeneCreation(String)
   /* case loading(String)
    case loaded*/
    
    var description: String {
        switch self{
            case .ready : return "state : .ready"
            case .nom_allergeneChanging(let na) : return "state : .nom_allergene(\(na))"
            case .allergeneCreation(let na) : return "state : .nom_allergene(\(na))"
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
    
    @MainActor
    func intentToChange(allergene: AllergeneVM) async{
        await AllergeneDAO.modifierAllergene(id_allergene: allergene.getId(), nom_allergene: allergene.nom_allergene)
        self.stateAllergene.send(.nom_allergeneChanging(allergene.nom_allergene))
    }
    
    @MainActor
    func intentToCreate(nom_allergene : String) async {
            await AllergeneDAO.createAllergene(nom_allergene: nom_allergene)
            self.stateAllergene.send(.allergeneCreation(nom_allergene))
        }
}

