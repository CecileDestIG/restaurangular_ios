//
//  EtapeDetailView.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 20/02/2022.
//

import Foundation
import SwiftUI

struct EtapeDetailView : View {
    @ObservedObject var etapeVM : EtapeVM
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentEtape : IntentEtape
    let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    init(evm : EtapeVM, elvm:EtapeListVM ){
        self.etapeVM=evm
        self.intentEtape=IntentEtape()
        self.intentEtape.addObserver(evm: evm)
        self.intentEtape.addObserver(elvm: elvm)
    }
    var body : some View {
        VStack{
            Text("\(etapeVM.titre_etape)").font(.largeTitle).bold()
            Form{
            HStack{
                Text("Titre : ");
                TextField("titre", text: $etapeVM.titre_etape)
                    
            }
            HStack{
                Text("Temps : ");
                TextField("temps", value: $etapeVM.temps_etape, formatter: formatter)
                    
            }
            HStack{
                Text("Description : ");
                TextEditor(text:  $etapeVM.description_etape)
            }
                HStack{
                    Spacer()
                Button("modifier"){
                    Task{
                        await intentEtape.intentToChange(etape: etapeVM)
                    }
                }
                    Spacer()
                }
            }
            Spacer()
        }.padding()
    }
}
