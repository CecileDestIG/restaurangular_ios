//
//  CatgeorieListVM.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 02/03/2022.
//

import Foundation
import Combine

class CategorieListVM : ObservableObject, Subscriber{
    
    typealias Input = IntentStateCategorie
    
    typealias Failure = Never
    
    public var categorie_list : [Categorie] = []{
        didSet{
            objectWillChange.send()
        }
    }

    init() {
        self.categorie_list = [Categorie()]
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
        
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(_ input: IntentStateCategorie) -> Subscribers.Demand {
        print("vm -> intent \(input)")
        switch input {
        case .ready:
            break
        case .nom_categorieChanging(_), .categorieCreation(_) :
            self.objectWillChange.send()
        }
        return .none
    }
    
}
