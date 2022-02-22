//
//  EtapeDetailView.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 20/02/2022.
//

import Foundation
import SwiftUI

struct EtapeDetailView : View {
    @ObservedObject var etapeVM : EtapeVM
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentEtape : IntentEtape
    
    init(evm : EtapeVM, elvm:EtapeListVM ){
        self.etapeVM=evm
        self.intentEtape=IntentEtape()
        self.intentEtape.addObserver(evm: evm)
        self.intentEtape.addObserver(elvm: elvm)
    }
    var body : some View {
        VStack{
            HStack{
                Text("Nom titre etape : ");
                TextField("modele", text: $etapeVM.titre_etape)
                    .onSubmit {
                        intentEtape.intentToChange(titre_etape: etapeVM.titre_etape)
                    }
            }
            HStack{
                Text("temps etape : ");
                TextField("modele", value: $etapeVM.temps_etape, formatter: NumberFormatter())
                    .onSubmit {
                        intentEtape.intentToChange(temps_etape: etapeVM.temps_etape)
                    }
            }
            HStack{
                Text("Description etape : ");
                TextField("modele", text: $etapeVM.description_etape)
                    .onSubmit {
                        intentEtape.intentToChange(description_etape: etapeVM.description_etape)
                    }
            }
            Spacer()
        }.padding()
    }
}
