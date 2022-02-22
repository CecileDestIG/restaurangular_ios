//
//  IntentEtape.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 20/02/2022.
//


import Foundation
import Combine

enum IntentStateEtape : CustomStringConvertible, Equatable {
    
    case ready
    case titre_etapeChanging(String)
    case temps_etapeChanging(Double)
    case description_etapeChanging(String)

    var description: String {
        switch self{
            case .ready : return "state : .ready"
            case .titre_etapeChanging(let e) : return "state : .titre_etape(\(e))"
            case .temps_etapeChanging(let e) : return "state : .temps_etape(\(e))"
            case .description_etapeChanging(let e) : return "state : .description_etape(\(e))"
        }
    }
}
    
struct IntentEtape {
    private var stateEtape = PassthroughSubject<IntentStateEtape,Never>()
    
    func addObserver(evm : EtapeVM){
        self.stateEtape.subscribe(evm)
    }
    
    func addObserver(elvm : EtapeListVM){
        self.stateEtape.subscribe(elvm)
    }
    
    func intentToChange(titre_etape:String){
        self.stateEtape.send(.titre_etapeChanging(titre_etape))
    }
    
    func intentToChange(temps_etape:Double){
        self.stateEtape.send(.temps_etapeChanging(temps_etape))
    }
    
    func intentToChange(description_etape:String){
        self.stateEtape.send(.description_etapeChanging(description_etape))
    }
}
