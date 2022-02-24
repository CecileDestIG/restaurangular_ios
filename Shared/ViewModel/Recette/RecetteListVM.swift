//
//  RecetteListVM.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 22/02/2022.
//

import Foundation
import Combine

class RecetteListVM : ObservableObject, Subscriber{
    
    public var recette_list : [Recette]{
        didSet{
            objectWillChange.send()
        }
    }
    
    typealias Input = IntentStateRecette
    
    typealias Failure = Never
    
    init(){
        self.recette_list = [Recette()]
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
        
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(_ input: IntentStateRecette) -> Subscribers.Demand {
        print("vm -> intent \(input)")
        switch input {
        case .ready:
            break
        case .id_createurChanging(_), .nom_recetteChanging(_), .nb_couvertChanging(_), .id_categorieChanging(_), .prix_venteChanging(_), .etapesChanging(_), .recinclusChanging(_), .ingredientsChanging(_) :
            self.objectWillChange.send()
        }
        return .none
    }
    
}
