//
//  CategorieVM.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 02/03/2022.
//

import Foundation
import Combine

enum CategorieVMError : Error, CustomStringConvertible, Equatable {
    case noError
    case nom_categorieError(String)
    
    var description: String {
        switch self {
        case .noError : return "No error"
        case .nom_categorieError(let nc) :  return "Erreur dans le nom de categorie de recette :  \(nc)"
        }
    }
}
    
class CategorieVM : ObservableObject, CategorieObserver, Subscriber{

    
    typealias Input = IntentStateCategorie
    
    typealias Failure = Never
    
        
    private var categorie : Categorie
    @Published var nom_categorie : String
    
    func getId()->Int{
        return self.categorie.id_categorie
    }
    
    func change(nom_categorie: String) {
        print("vm observer: nom_categorie changé => self.nom_categorie = '\(nom_categorie)'")
        self.nom_categorie=nom_categorie
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
        case .ready :
            break
        case .nom_categorieChanging(let nc):
            let ncClean = nc.trimmingCharacters(in: .whitespacesAndNewlines)
            print("vm : change model nom categorie to '\(ncClean)'")
            self.categorie.nom_categorie=ncClean
            print("vm : change model nom cat ingr to '\(self.categorie.nom_categorie)'")
        case .categorieCreation(let nc):
            print("creation categorie \(nc)")
        }
        return .none
    }
    
    init(_ c : Categorie = Categorie()){
        self.categorie = c
        self.nom_categorie=c.nom_categorie
    }
}
