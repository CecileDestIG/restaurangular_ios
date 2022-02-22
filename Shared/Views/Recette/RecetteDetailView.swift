//
//  RecetteDetailView.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 22/02/2022.
//

import Foundation
import SwiftUI

struct RecetteDetailView : View {
    @ObservedObject var recetteVM : RecetteVM
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentR : IntentRecette
    
    init(rvm : RecetteVM, rlvm:RecetteListVM ){
        self.recetteVM=rvm
        self.intentR=IntentRecette()
        self.intentR.addObserver(rvm: rvm)
        self.intentR.addObserver(rlvm: rlvm)

    }
    
    var body : some View {
        VStack{
            HStack{
                Text("Nom recette : ");
                TextField("modele", text: $recetteVM.nom_recette)
                    .onSubmit {
                        intentR.intentToChange(nom_recette: recetteVM.nom_recette)
                    }
            }
                HStack{
                    Text("Nb couvert : ");
                    TextField("modele",value:$recetteVM.nb_couvert, formatter: NumberFormatter())
                        .onSubmit {
                            intentR.intentToChange(nb_couvert: recetteVM.nb_couvert)
                        }
                }
            HStack{
                Text("Prix vente : ");
                TextField("modele",value:$recetteVM.prix_vente, formatter: NumberFormatter())
                    .onSubmit {
                        intentR.intentToChange(prix_vente: recetteVM.prix_vente)
                    }
            }
            Spacer()
        }.padding()
    }
}
