//
//  AllergeneListVM.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 19/02/2022.
//

import Foundation
import Combine

class AllergeneListVM : ObservableObject, Subscriber{
    
    public var allergeneList : [Allergene]
    
    typealias Input = IntentStateAllergene
    
    typealias Failure = Never
    
    init(allergenelist : [Allergene]){
        self.allergeneList=allergenelist
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
        
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(_ input: IntentStateAllergene) -> Subscribers.Demand {
        print("vm -> intent \(input)")
        switch input {
        case .ready:
            break
        case .nom_allergeneChanging(_) :
            self.objectWillChange.send()
        }
        return .none
    }
    
}
