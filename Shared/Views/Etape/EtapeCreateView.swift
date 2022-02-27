//
//  EtapeCreateView.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 27/02/2022.
//

import Foundation
import SwiftUI

struct EtapeCreateView : View {
    @ObservedObject var etapeVM : EtapeVM = EtapeVM(e:Etape())
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentEtape : IntentEtape
    
    init(elvm:EtapeListVM ){
        self.intentEtape=IntentEtape()
        self.intentEtape.addObserver(elvm: elvm)
    }
    var body : some View {
        VStack{
            Form{
            HStack{
                Text("Nom titre etape : ");
                TextField("modele", text: $etapeVM.titre_etape)
                    
            }
            HStack{
                Text("temps etape : ");
                TextField("modele", value: $etapeVM.temps_etape, formatter: NumberFormatter())
                    
            }
            HStack{
                Text("Description etape : ");
                TextField("modele", text: $etapeVM.description_etape)
            }
                Button("creer"){
                    Task{
                        await intentEtape.intentToCreate(etape: etapeVM)
                    }
                }
            }
            Spacer()
        }.padding()
    }
}
