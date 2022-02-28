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
            Text("Création Etape").font(.largeTitle).bold()
            Form{
            HStack{
                Text("Titre : ");
                TextField("titre", text: $etapeVM.titre_etape)
                    
            }
            HStack{
                Text("Temps : ");
                TextField("temps", value: $etapeVM.temps_etape, formatter: NumberFormatter())
                    
            }
            HStack{
                Text("Description : ");
                TextEditor(text:  $etapeVM.description_etape)
            }
                HStack{
                    Spacer()
                    Button("creer"){
                        Task{
                            await intentEtape.intentToCreate(etape: etapeVM)
                        }
                    }
                    Spacer()
                }
            }
            Spacer()
        }.padding()
    }
}
