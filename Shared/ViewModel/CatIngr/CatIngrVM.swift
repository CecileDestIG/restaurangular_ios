//
//  CatIngrVM.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 19/02/2022.
//

import Foundation
import Combine

enum CatIngrVMError : Error, CustomStringConvertible, Equatable {
    case noError
    case nom_cat_ingrError(String)
    
    var description: String {
        switch self {
        case .noError : return "No error"
        case .nom_cat_ingrError(let nci) :  return "Erreur dans le nom de categorie d'ingredient :  \(nci)"
        }
    }
}
    
class CatIngrVM : ObservableObject, CatIngrObserver, Subscriber{

    
    typealias Input = IntentStateCatIngr
    
    typealias Failure = Never
    
        
    private var catingr : CatIngr
    @Published var nom_cat_ingr : String
    
    func change(nom_cat_ingr: String) {
        print("vm observer: nom_cat_ingr changé => self.nom_cat_ingr = '\(nom_cat_ingr)'")
        self.nom_cat_ingr=nom_cat_ingr
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
        case .ready :
            break
        case .nom_cat_ingrChanging(let nci):
            let nciClean = nci.trimmingCharacters(in: .whitespacesAndNewlines)
            print("vm : change model nom cat ingr to '\(nciClean)'")
            self.catingr.nom_cat_ingr=nciClean
            print("vm : change model nom cat ingr to '\(self.catingr.nom_cat_ingr)'")
        }
        return .none
    }
    
    init(ci : CatIngr){
        self.catingr=ci
        self.nom_cat_ingr=ci.nom_cat_ingr
    }
}
