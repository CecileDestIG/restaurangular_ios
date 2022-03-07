//
//  IntentRecette.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 22/02/2022.
//

import Foundation
import Combine

enum IntentStateRecette : CustomStringConvertible, Equatable {
    static func == (lhs: IntentStateRecette, rhs: IntentStateRecette) -> Bool {
        return false
    }
    
    case ready
    case recetteCreate(RecetteVM)
    case recetteChanging(RecetteVM)

    var description: String {
        switch self{
            case .ready : return "state : .ready"
            case .recetteCreate(let r) :  return "state : .recette(\(r.nom_recette))"
            case .recetteChanging(let r): return "state : .recette(\(r.nom_recette))"
        }
    }
}
    
struct IntentRecette {
    private var stateRecette = PassthroughSubject<IntentStateRecette,Never>()
    
    func addObserver(rvm : RecetteVM){
        self.stateRecette.subscribe(rvm)
    }
    
    func addObserver(rlvm : RecetteListVM){
        self.stateRecette.subscribe(rlvm)
    }
    
    @MainActor
    func intentToCreate(recette:RecetteVM,recincl:[RecetteInclusCreateDTO], etincl:[EtapeCreateRecetteDTO], ingr: [IngredientCreateRecetteDTO] ) async{
        
        if (recincl.isEmpty){
            await RecetteDAO.createRecette(recette:recette,recincl:nil,etincl: etincl, ingredients: ingr)
        }
        else{
            await RecetteDAO.createRecette(recette:recette,recincl:recincl,etincl:etincl, ingredients: ingr)
        }
        
        self.stateRecette.send(.recetteCreate(recette))
    }
    
    @MainActor
    func intentToDelete(id:Int) async {
        await RecetteDAO.deleteRecette(id: id)
    }
    
    func intentToLoad() async -> [Recette]?{
        if let list = await RecetteDAO.getAllRecette(){
            return list.sorted{$0.nom_recette < $1.nom_recette}
        }
        else{
            return nil
        }
            
    }
    
    @MainActor
    func intentToModify(recette:RecetteVM,recincl:[RecetteInclusCreateDTO], etincl:[EtapeCreateRecetteDTO], ingr: [IngredientCreateRecetteDTO] ) async{
        self.stateRecette.send(.recetteChanging(recette))
        if (recincl.isEmpty){
            await RecetteDAO.modifyRecette(recette:recette,recincl:nil,etincl: etincl, ingredients: ingr)
        }
        else{
            await RecetteDAO.modifyRecette(recette:recette,recincl:recincl,etincl:etincl, ingredients: ingr)
        }
    }
    
}
