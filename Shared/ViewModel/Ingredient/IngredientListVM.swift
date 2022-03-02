//
//  IngredientListVM.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 19/02/2022.
//

import Foundation
import Combine

class IngredientListVM : ObservableObject, Subscriber{
    
    public var ingredient_list : [Ingredient]{
        didSet{
            objectWillChange.send()
        }
    }
    
    typealias Input = IntentStateIngredient
    
    typealias Failure = Never
    
    init(){
        self.ingredient_list = [Ingredient()]
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
        case .ingredientCreate(_), .ingredientChanging(_) :
            self.objectWillChange.send()
        }
        return .none
    }
    
}
