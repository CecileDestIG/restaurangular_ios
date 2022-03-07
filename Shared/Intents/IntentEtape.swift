//
//  IntentEtape.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 20/02/2022.
//


import Foundation
import Combine

enum IntentStateEtape : CustomStringConvertible, Equatable {
    static func == (lhs: IntentStateEtape, rhs: IntentStateEtape) -> Bool {
        lhs==rhs
    }
    
    case ready
    case etapeChanging(EtapeVM)
    case etapeCreation(String)

    var description: String {
        switch self{
            case .ready : return "state : .ready"
            case .etapeChanging(let e) : return "state : .etape(\(e))"
            case .etapeCreation(let e): return "state : etape create \(e)"
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
    
    @MainActor
    func intentToChange(etape:EtapeVM) async{
        await EtapeDAO.modifierEtape(etape: etape)
        self.stateEtape.send(.etapeChanging(etape))
    }
    
    @MainActor
    func intentToCreate(etape : EtapeVM) async{
        await EtapeDAO.createEtape(etape: etape)
        self.stateEtape.send(.etapeCreation(etape.titre_etape))
    }
    
    func intentToLoad(etapes:EtapeListVM) async -> [Etape]?{
        if let list = await EtapeDAO.getAllEtape(){
            return list.sorted{$0.titre_etape < $1.titre_etape}
        }
        else{
            return nil
        }
    }
}
