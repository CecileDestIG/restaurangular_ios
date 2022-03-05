//
//  EtapeVM.swift
//  Restaurangular (iOS)
//
//  Created by Cécile on 20/02/2022.
//


import Foundation
import Combine

enum EtapeVMError : Error, CustomStringConvertible, Equatable {
    case noError
    case titre_etapeError(String)
    case temps_etapeError(Double)
    case description_etapeError(String)

    var description: String {
        switch self {
        case .noError : return "No error"
        case .titre_etapeError(let e) :  return "Erreur dans le titre etape :  \(e)"
        case .temps_etapeError(let e) :  return "Erreur dans le temps etape :  \(e)"
        case .description_etapeError(let e) :  return "Erreur dans le description etape :  \(e)"

        }
    }
}
    
class EtapeVM : ObservableObject, EtapeObserver, Subscriber, Hashable{
    
    static func == (lhs: EtapeVM, rhs: EtapeVM) -> Bool {
        lhs.getId()==rhs.getId()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(etape.id_etape)
    }
    
    typealias Input = IntentStateEtape
    
    typealias Failure = Never
    
        
    private var etape : Etape
    @Published var titre_etape : String
    @Published var temps_etape : Double
    @Published var description_etape : String

    func getId()->Int{
        return self.etape.id_etape
    }
    
    func change(titre_etape: String) {
        print("vm observer: titre_etape changé => self.titre_etape = '\(titre_etape)'")
        self.titre_etape=titre_etape
    }
    
    func change(temps_etape: Double) {
        print("vm observer: temps_etape changé => self.temps_etape = '\(temps_etape)'")
        self.temps_etape=temps_etape
    }
    
    func change(description_etape: String) {
        print("vm observer: description_etape changé => self.description_etape = '\(description_etape)'")
        self.description_etape=description_etape
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
        case .ready :
            break
        case .etapeChanging(let e):
            let eClean = e.titre_etape.trimmingCharacters(in: .whitespacesAndNewlines)
            print("vm : change model titre  to '\(eClean)'")
            self.etape.titre_etape=eClean
            print("vm : change model titre to '\(self.etape.titre_etape)'")
            self.etape.temps_etape=e.temps_etape
            print("vm : change model titre to '\(self.etape.temps_etape)'")
            let desClean = e.description_etape.trimmingCharacters(in: .whitespacesAndNewlines)
            print("vm : change model titre  to '\(desClean)'")
            self.etape.description_etape=desClean
            print("vm : change model titre to '\(self.etape.description_etape)'")
        case .etapeCreation(_):
            print("creation etape")
        }
        
        return .none
    }
    
    init(e : Etape){
        self.etape=e
        self.titre_etape=e.titre_etape
        self.temps_etape=e.temps_etape
        self.description_etape=e.description_etape
    }
}
