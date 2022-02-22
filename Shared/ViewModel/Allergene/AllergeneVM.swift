//
//  AllergeneVM.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 19/02/2022.
//

import Foundation
import Combine

enum AllergeneVMError : Error, CustomStringConvertible, Equatable {
    case noError
    case nom_allergeneError(String)
    
    var description: String {
        switch self {
        case .noError : return "No error"
        case .nom_allergeneError(let na) :  return "Erreur dans le nom d'allergene :  \(na)"
        }
    }
}
    
class AllergeneVM : ObservableObject, AllergeneObserver, Subscriber{

    
    typealias Input = IntentStateAllergene
    
    typealias Failure = Never
    
        
    private var allergene : Allergene
    @Published var nom_allergene : String
    
    func change(nom_allergene: String) {
        print("vm observer: nom_allergene changé => self.nom_allergene = '\(nom_allergene)'")
        self.nom_allergene=nom_allergene
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
        case .ready :
            break
        case .nom_allergeneChanging(let na):
            let naClean = na.trimmingCharacters(in: .whitespacesAndNewlines)
            print("vm : change model nom_allergene to '\(naClean)'")
            self.allergene.nom_allergene=naClean
            print("vm : change model nom_allergene to '\(self.allergene.nom_allergene)'")
        }
        return .none
    }
    
    init(allergene : Allergene){
        self.allergene=allergene
        self.nom_allergene=allergene.nom_allergene
    }
}

