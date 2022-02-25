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
    @State var recette : Recette = Recette()
    
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
        .task{
            if let rec = await RecetteDAO.getRecette(id_recette: 0){
                self.recette = rec
            }
        }
        VStack {
            HStack{
                Text("ID : "+"\(recette.id_recette)")
            }
            HStack{
                Text("Nom : "+"\(recette.nom_recette)")
            }
            HStack{
                Text("Nombre de couverts : "+"\(recette.nb_couvert)")
            }
            HStack{
                Text("ID Catégorie : "+"\(recette.id_categorie)")
            }
            HStack{
                Text("Prix vente :"+"\(recette.prix_vente)")
            }
            HStack{
                if (recette.etapes != nil){
                    ForEach(recette.etapes!, id:\.id_etape){item in
                        VStack{
                            Text("id : "+"\(item.id_etape)")
                            Text("position : "+"\(item.place_et)")
                        }
                    }
                }
            }
            HStack{
                if (recette.recinclus != nil){
                    ForEach(recette.recinclus!, id:\.id_recincl){item in
                        VStack{
                            Text("id : "+"\(item.id_recincl)")
                            Text("position : "+"\(item.place_rec)")
                        }
                    }
                }
            }
            HStack{
                if (recette.ingredients != nil){
                    ForEach(recette.ingredients!, id:\.id_ingredient){item in
                        VStack{
                            Text("id : "+"\(item.id_ingredient)")
                            Text("quantite : "+"\(item.quantite_necessaire)")
                        }
                    }
                }
            }
        }
    }
}
