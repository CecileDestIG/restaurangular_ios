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
        formatter.maximumIntegerDigits = 2
        return formatter
    }()
    
    init(rvm : RecetteVM, rlvm:RecetteListVM ){
        self.recetteVM=rvm
        self.intentR=IntentRecette()
        self.intentR.addObserver(rvm: rvm)
        self.intentR.addObserver(rlvm: rlvm)
        self.recetteList = rlvm
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
                Divider()
                if((self.recetteVM.recinclus != nil) || (self.recetteVM.etapes != nil)){
                    VStack{
                        Text("Progression")
                        EtapeRecetteInclusView(recette: self.recetteVM,liste_recette: self.recetteList)
                    }
                    .padding()
                }
                Divider()
                VStack(spacing:20){
                    if (recetteVM.ingredients != nil){
                        Text("INGREDIENTS")
                        ForEach(recetteVM.ingredients!, id:\.id_ingredient){item in
                            HStack(spacing:20){
                                Text("\(item.nom_ingredient)")
                                Text("Quantite : \(item.quantite_necessaire)\(item.unite)")
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}


struct EtapeRecetteInclusView : View {
    let recette : RecetteVM
    let liste_recette : RecetteListVM
    var indexList : [Int : String] {
        var indexList : [Int : String] = [0:""]
        if let l1 = recette.recinclus {
            for r in l1{
                indexList[r.place_rec] = "recette"
            }
        }
        if let l2 = recette.etapes {
            for r in l2{
                indexList[r.place_et] = "etape"
            }
        }
        return indexList
    }
    
    func findRecetteInclus(position : Int) -> RecetteInclus{
        var recetteInclus : RecetteInclus = RecetteInclus()
        for r in self.recette.recinclus! {
            if(r.place_rec == position){
                print("recette incluse trouvée")
                recetteInclus = r
            }
        }
        return recetteInclus
    }
    
    func findEtapeInclus(position : Int) -> EtapeInclus{
        var etapeInclus : EtapeInclus = EtapeInclus()
        for e in self.recette.etapes! {
            if(e.place_et == position){
                print("etape incluse trouvée")
                etapeInclus = e
            }
        }
        return etapeInclus
    }
    
    func findRecette(id : Int,list : RecetteListVM) -> Recette{
        var recette : Recette = Recette()
        for r in list.recette_list {
            if(r.id_recette == id){
                print("recette trouvée: ",r)
                recette = r
            }
        }
        return recette
    }
    var body: some View{
        ForEach(self.indexList.sorted(by: <),id:\.key){ key,value in
            if(value == "recette"){
                let r = findRecetteInclus(position: key)
                let r2 = findRecette(id: r.id_recincl, list: self.liste_recette)
                HStack{
                    Text("\(key) : ")
                    Text("\(r2.nom_recette)")
                }.padding()
            }
            if(value == "etape"){
                let e = findEtapeInclus(position: key)
                HStack{
                    Text("\(key) : ")
                    Text("\(e.titre_etape)")
                }.padding()
            }
        }
    }
}
