//
//  IntentIngredient.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 19/02/2022.
//

import Foundation
import Combine

enum IntentStateIngredient : CustomStringConvertible, Equatable {
    
    case ready
    case nom_ingredientChanging(String)
    case uniteChanging(String)
    case cout_unitaireChanging(Double)
    case stockChanging(Double)
    case id_cat_ingrChanging(Int)
    case id_allergeneChanging(Int)
    
    var description: String {
        switch self{
            case .ready : return "state : .ready"
            case .nom_ingredientChanging(let i) : return "state : .nom_ingredient(\(i))"
            case .uniteChanging(let i) : return "state : .unite(\(i))"
            case .cout_unitaireChanging(let i) : return "state : .coutunitaire(\(i))"
            case .stockChanging(let i) : return "state : .stock(\(i))"
            case .id_cat_ingrChanging(let i) : return "state : .id_cat_ingr(\(i))"
            case .id_allergeneChanging(let i) : return "state : .id_allergene(\(i))"
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
    
    func intentToChange(nom_ingredient:String){
        self.stateIngredient.send(.nom_ingredientChanging(nom_ingredient))
    }
    
    func intentToChange(unite:String){
        self.stateIngredient.send(.uniteChanging(unite))
    }
    
    func intentToChange(cout_unitaire:Double){
        self.stateIngredient.send(.cout_unitaireChanging(cout_unitaire))
    }
    
    func intentToChange(stock:Double){
        self.stateIngredient.send(.stockChanging(stock))
    }
    
    func intentToChange(id_cat_ingr:Int){
        self.stateIngredient.send(.id_cat_ingrChanging(id_cat_ingr))
    }
    
    func intentToChange(id_allergene:Int){
        self.stateIngredient.send(.id_allergeneChanging(id_allergene))
    }
}

