//
//  AllergeneListVM.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 19/02/2022.
//

//TODO verifier que le nom est pas nul quand on créer

import Foundation
import Combine

class AllergeneListVM : ObservableObject, Subscriber{
    
    public var allergeneList : [Allergene]{
        didSet{
            objectWillChange.send()
        }
    }
    
    typealias Input = IntentStateAllergene
    
    typealias Failure = Never
    
    init(_ allergenelist : [Allergene] = [Allergene()]){
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
        case .nom_allergeneChanging(_), .allergeneCreation(_) :
            self.objectWillChange.send()
        }
        return .none
    }
    
}
