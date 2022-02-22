//
//  IngredientListVM.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 19/02/2022.
//

import Foundation
import Combine

class IngredientListVM : ObservableObject, Subscriber{
    
    public var iList : [Ingredient]
    
    typealias Input = IntentStateIngredient
    
    typealias Failure = Never
    
    init(ilist : [Ingredient]){
        self.iList=ilist
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
        
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(_ input: IntentStateIngredient) -> Subscribers.Demand {
        print("vm -> intent \(input)")
        switch input {
        case .ready:
            break
        case .nom_ingredientChanging(_), .uniteChanging(_), .cout_unitaireChanging(_), .stockChanging(_), .id_allergeneChanging(_), .id_cat_ingrChanging(_) :
            self.objectWillChange.send()
        }
        return .none
    }
    
}
