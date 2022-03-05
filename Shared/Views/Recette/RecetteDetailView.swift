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
    
    init(rvm : RecetteVM, rlvm:RecetteListVM){
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
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.pink,lineWidth: 2)
                        )
                        .foregroundColor(Color.pink)
                    VStack(spacing:20){
                        Text("Prix vente")
                            .bold()
                        Text("\(recetteVM.prix_vente,specifier: "%.2f") €")
                    }.padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.pink,lineWidth: 2)
                        )
                        .foregroundColor(Color.pink)
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
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.pink,lineWidth: 2)
                )
                .foregroundColor(Color.pink)
                Divider()
                if((self.recetteVM.recinclus != nil) || (self.recetteVM.etapes != nil)){
                    VStack{
                        Text("PROGRESSION")
                            .bold()
                            .padding()
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
    var etapeList : EtapeListVM = EtapeListVM()
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
    
    func findEtape(id : Int,list : EtapeListVM) -> Etape{
        var etape : Etape = Etape()
        for e in list.etape_list {
            if(e.id_etape == id){
                print("etape trouvée: ",e)
                etape = e
            }
        }
        return etape
    }
    
    var body: some View{
        VStack{
            ForEach(self.indexList.sorted(by: <),id:\.key){ key,value in
                if(value == "recette"){
                    let r = findRecetteInclus(position: key)
                    let r2 = findRecette(id: r.id_recincl, list: self.liste_recette)
                    RecetteInclusView(r: r2, rl: self.liste_recette,position:key)
                }
                if(value == "etape"){
                    let e = findEtapeInclus(position: key)
                    let e2 = findEtape(id: e.id_etape, list: self.etapeList)
                    EtapeInclusView(e: e,position: key)
                }
            }
        }
        .task{
            // ETAPES
            if let list = await EtapeDAO.getAllEtape(){
                self.etapeList.etape_list = list
            }
        }
    }
}

struct EtapeInclusView : View {
    
    let e : EtapeInclus
    let position : Int
    
    var body: some View {
        VStack{
            VStack{
                Text("\(position) | "+e.titre_etape)
                    .bold()
                Text("(\(e.temps_etape,specifier: "%.1f") minute)")
                Text(e.description_etape).frame(width:250,height:100)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.purple,lineWidth: 2)
        )
        .foregroundColor(Color.purple)
    }
}

struct RecetteInclusView : View {
    
    let r : Recette
    let rl : RecetteListVM
    let position : Int
    
    var body: some View {
        VStack{
            Text("\(position) | "+r.nom_recette)
                .bold().padding()
            Text(r.nom_categorie)
            Text("pour \(r.nb_couvert) personnes")
            Text("à \(r.prix_vente,specifier: "%.2f") €")
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.pink,lineWidth: 2)
        )
        .foregroundColor(Color.pink)
    }
}
