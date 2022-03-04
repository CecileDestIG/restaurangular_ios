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
                    Text("Pour \(recetteVM.nb_couvert) personnes");
                }
                HStack(spacing:10){
                    if let url = recetteVM.image {
                        AsyncImage(url: URL(string:url),content: { img in
                            img
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200, alignment: .center)
                            .scaledToFit()
                            .cornerRadius(20)
                        },placeholder: {
                            ProgressView()
                        })
                    }
                    else{
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200, alignment: .center)
                            .scaledToFit()
                            .cornerRadius(20)
                    }
                }
                HStack{
                    VStack(spacing:20){
                        Text("Catégorie")
                            .bold()
                        Text(recetteVM.nom_categorie)
                    }.padding()
                    VStack(spacing:20){
                        Text("Prix vente")
                            .bold()
                        Text("\(recetteVM.prix_vente,specifier: "%.2f") €")
                    }.padding()
                }
                Divider()
                VStack(spacing:20){
                    if (recetteVM.ingredients != nil){
                        Text("INGREDIENTS")
                            .bold()
                        ForEach(recetteVM.ingredients!, id:\.id_ingredient){item in
                            HStack(spacing:20){
                                Text("\(item.nom_ingredient) : ")
                                Text("\(item.quantite_necessaire,specifier: "%.2f") \(item.unite)")
                            }
                        }
                    }
                }
                Divider()
                if((self.recetteVM.recinclus != nil) || (self.recetteVM.etapes != nil)){
                    VStack{
                        Text("PROGRESSION")
                            .bold()
                        EtapeRecetteInclusView(recette: self.recetteVM,liste_recette: self.recetteList)
                    }
                    .padding()
                }
            }
            .padding()
        }.navigationTitle(recetteVM.nom_recette)
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
                    Text("\(key). ")
                    Text("\(r2.nom_recette)")
                }
            }
            if(value == "etape"){
                let e = findEtapeInclus(position: key)
                HStack{
                    Text("\(key). ")
                    Text("\(e.titre_etape)")
                }
            }
        }
    }
}
