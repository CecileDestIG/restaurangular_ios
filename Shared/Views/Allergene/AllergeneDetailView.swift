//
//  AllergeneDetailView.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 19/02/2022.
//

import Foundation
import SwiftUI

struct AllergeneDetailView : View {
    @ObservedObject var allergeneVM : AllergeneVM
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentAl : IntentAllergene
    
    init(avm : AllergeneVM, alvm:AllergeneListVM ){
        self.allergeneVM=avm
        self.intentAl=IntentAllergene()
        self.intentAl.addObserver(avm: avm)
        self.intentAl.addObserver(alvm: alvm)

    }
    
    var body : some View {
        VStack{
            HStack{
                Text("Nom allergene : ");
                TextField("modele", text: $allergeneVM.nom_allergene)
                    .onSubmit {
                        intentAl.intentToChange(nom_allergene: allergeneVM.nom_allergene)
                    }
            }
            Spacer()
        }.padding()
    }
}
