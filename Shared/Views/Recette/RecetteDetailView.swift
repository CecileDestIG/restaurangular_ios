//
//  RecetteDetailView.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 22/02/2022.
//

import Foundation
import SwiftUI

struct RecetteDetailView : View {
    @ObservedObject var recetteVM : RecetteVM
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentR : IntentRecette
    var recetteList : RecetteListVM
    let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    init(rvm : RecetteVM, rlvm:RecetteListVM ){
        self.recetteVM=rvm
        self.intentR=IntentRecette()
        self.intentR.addObserver(rvm: rvm)
        self.intentR.addObserver(rlvm: rlvm)
        self.recetteList = rlvm
    }
    
    func findRecette(id : Int,list : RecetteListVM) -> Recette{
        var recette : Recette = Recette()
        for r in list.recette_list {
            if(r.id_recette == id){
                recette = r
            }
        }
        return recette
    }
    
    var body : some View {
        List{
            VStack(spacing:20){
                HStack(spacing:20){
                    Text("Nom recette : ");
                    TextField("modele", text: $recetteVM.nom_recette)
                        .onSubmit {
                            intentR.intentToChange(nom_recette: recetteVM.nom_recette)
                        }
                }
                HStack(spacing:20){
                    Text("Nb couvert : ");
                    TextField("modele",value:$recetteVM.nb_couvert, formatter: NumberFormatter())
                        .onSubmit {
                            intentR.intentToChange(nb_couvert: recetteVM.nb_couvert)
                        }
                }
                HStack(spacing:20){
                    Text("Prix vente : ");
                    TextField("modele",value:$recetteVM.prix_vente, formatter:formatter)
                        .onSubmit {
                            intentR.intentToChange(prix_vente: recetteVM.prix_vente)
                        }
                }
                HStack(spacing:20){
                    Text("Catégorie : \(recetteVM.nom_categorie)")
                }
                HStack(spacing:20){
                    Text("Prix vente : \(recetteVM.prix_vente)")
                }
                VStack(spacing:20){
                    if (recetteVM.etapes != nil){
                        Text("ETAPES")
                        ForEach(recetteVM.etapes!, id:\.id_etape){item in
                            VStack(spacing:20){
                                HStack{
                                    Text("\(item.titre_etape)")
                                    Text("Position : "+"\(item.place_et)")
                                }
                            }
                        }
                    }
                }
                Divider()
                VStack(spacing:20){
                    if (recetteVM.recinclus != nil){
                        Text("SOUS-RECETTES")
                        ForEach(recetteVM.recinclus!, id:\.id_recincl){item in
                            VStack(spacing:20){
                                let r = findRecette(id:item.id_recincl,list:recetteList)
                                HStack{
                                    Text("\(r.nom_recette)")
                                    Text("Position : "+"\(item.place_rec)")
                                }
                            }
                        }
                    }
                }
                Divider()
                VStack(spacing:20){
                    if (recetteVM.ingredients != nil){
                        Text("INGREDIENTS")
                        ForEach(recetteVM.ingredients!, id:\.id_ingredient){item in
                            VStack(spacing:20){
                                Text("\(item.nom_ingredient)")
                                Text("Quantite : \(item.quantite_necessaire)\(item.unite)")
                            }
                        }
                    }
                }
            }.padding()
        }
    }
}
