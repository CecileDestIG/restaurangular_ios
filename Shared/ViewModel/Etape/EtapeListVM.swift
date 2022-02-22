//
//  EtapeListVM.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 20/02/2022.
//

import Foundation
import Combine

class EtapeListVM : ObservableObject, Subscriber{
    
    public var eList : [Etape]
    
    typealias Input = IntentStateEtape
    
    typealias Failure = Never
    
    init(elist : [Etape]){
        self.eList=elist
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
        
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(_ input: IntentStateEtape) -> Subscribers.Demand {
        print("vm -> intent \(input)")
        switch input {
        case .ready:
            break
        case .temps_etapeChanging(_), .titre_etapeChanging(_), .description_etapeChanging(_):
            self.objectWillChange.send()
        }
        return .none
    }
    
}
