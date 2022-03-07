//
//  IntentIngredient.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 19/02/2022.
//

import Foundation
import Combine

enum IntentStateIngredient : CustomStringConvertible, Equatable {
    static func == (lhs: IntentStateIngredient, rhs: IntentStateIngredient) -> Bool {
        return false
    }
    
    case ready
    case ingredientChanging(IngredientVM)
    case ingredientCreate(String)
    
    var description: String {
        switch self{
            case .ready : return "state : .ready"
            case .ingredientCreate(let i): return "state : .nom_ingredient(\(i))"
            case .ingredientChanging(let i): return "state : .nom_ingredient(\(i))"
        }
    }
}
    
struct IntentIngredient {
    private var stateIngredient = PassthroughSubject<IntentStateIngredient,Never>()
    
    func addObserver(ivm : IngredientVM){
        self.stateIngredient.subscribe(ivm)
    }
    
    func addObserver(ilvm : IngredientListVM){
        self.stateIngredient.subscribe(ilvm)
    }
    
    @MainActor
    func intentToChange(ingredient:IngredientVM) async{
        await IngredientDAO.modifierCatingr(ingredient: ingredient)
        self.stateIngredient.send(.ingredientChanging(ingredient))
    }
    
    @MainActor
    func intentToCreate(ingredient : IngredientVM) async{
        await IngredientDAO.createIngredient(ingredient: ingredient)
        self.stateIngredient.send(.ingredientCreate(ingredient.nom_ingredient))
    }
    
    func intentToLoad() async -> [Ingredient]?{
        if let list = await IngredientDAO.getAllIngredient(){
            return list.sorted{$0.nom_ingredient < $1.nom_ingredient}
        }
        else{
            return nil
        }
    }
}

