//
//  CatIngrListVM.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 19/02/2022.
//

import Foundation
import Combine

class CatIngrListVM : ObservableObject, Subscriber{
    
    typealias Input = IntentStateCatIngr
    
    typealias Failure = Never
    
    public var cat_ingr_list : [CatIngr] = []{
        didSet{
            objectWillChange.send()
        }
    }

    init() {
        self.cat_ingr_list = [CatIngr()]
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
        
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(_ input: IntentStateCatIngr) -> Subscribers.Demand {
        print("vm -> intent \(input)")
        switch input {
        case .ready:
            break
        case .nom_cat_ingrChanging(_) :
            self.objectWillChange.send()
        }
        return .none
    }
    
}
