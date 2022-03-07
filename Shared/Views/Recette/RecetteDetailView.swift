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
        Form{
            Section{
                HStack{
                    Spacer()
                    Button("Supprimer") {
                        Task{
                            await intentR.intentToDelete(id: self.recetteVM.getId())
                            print("suppr")
                        }
                    }
                    Spacer()
                }
            }
            Section{
        List{
            VStack(spacing:20){
                
                HStack(spacing:20){
                    Text("Pour \(recetteVM.nb_couvert) personnes");
                }
                HStack(spacing:10){
                    if (recetteVM.image != "") {
                        AsyncImage(url: URL(string:recetteVM.image),content: { img in
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
                VStack(spacing:20){
                    Text("Durée")
                        .bold()
                    Text("\(recetteVM.tempsRecette(),specifier: "%.0f") minutes")
                }.padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.pink,lineWidth: 2)
                    )
                    .foregroundColor(Color.pink)
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
                }
                Divider()
                VStack{
                    CoutView(recette: recetteVM)
                }
            }
            .padding()
        }}.navigationTitle(recetteVM.nom_recette)
        }
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
                    Spacer(minLength: 20)

                }
                if(value == "etape"){
                    let e = findEtapeInclus(position: key)
                    let e2 = findEtape(id: e.id_etape, list: self.etapeList)
                    EtapeInclusView(e: e,position: key)
                    Spacer(minLength: 20)
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
            VStack(spacing:15){
                HStack{
                    Text("\(position) | "+e.titre_etape).bold()
                    Text("(\(e.temps_etape,specifier: "%.0f") min)")
                }
                Text(e.description_etape)
            }
        }.frame(width: 250, height: 200)
        .scenePadding()
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
            VStack{
                NavigationLink(destination:RecetteDetailView(rvm: RecetteVM(r:self.r), rlvm: self.rl)){
                    Button("Voir"){}
                }.scenePadding()
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.pink,lineWidth: 2)
        )
        .foregroundColor(Color.pink)
    }
}


struct CoutView : View {
    
    @State var typeAssaisonnement : Bool = false // Vrai -> assaisonnement relatif, Faux -> assasionnement absolu
    @State var assaisonnementRelatif : Double = 0
    @State var assaisonnementAbsolu : Double = 0
    @State var coutFluide : Double = 0
    @State var coutPersonnel : Double = 10
    @State var charge : Bool = false
    
    let recette : RecetteVM
    var cm : Double{
        return recette.coutMatiere(type:typeAssaisonnement,relatif: assaisonnementRelatif, absolu: assaisonnementAbsolu)
    }
    var cc : Double{
        return recette.coutCharge(coutFluide: coutFluide, coutPersonnel: coutPersonnel)
    }
    var cp : Double{
        return recette.coutProduction(type:charge,coutMatiere: cm, coutCharge: cc)
    }
    
    let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View{
        VStack(spacing:40){
            Text("Calcul des coûts").bold()
            VStack{
                Text("Coût matiere")
                Toggle("Type d'assaisonnement",isOn:$typeAssaisonnement)
                    if(typeAssaisonnement){
                        VStack{
                            Text("Assaisonnement relatif au coût matière")
                            HStack{
                                TextField("coefficient",value : $assaisonnementRelatif, formatter: formatter)
                                Text("%")
                            }.padding()
                        }
                    }
                    else{
                        VStack{
                            Text("Assaisonnement absolu")
                                HStack{
                                TextField("valeur",value : $assaisonnementAbsolu, formatter: formatter)
                                Text("€")
                                }.padding()
                        }
                    }
                Text("Coût matière : \(cm,specifier:"%.2f") €")
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue,lineWidth: 2)
            )
            .foregroundColor(Color.blue)
            .background(Color.white)
            VStack(spacing:20){
                VStack{
                    Text("Coût des charges").bold()
                    Text("(\(recette.tempsRecette(),specifier:"%.0f") minutes)")
                }
                HStack(spacing:5){
                    VStack{
                        Text("Fluides").bold()
                        HStack{
                            TextField("",value : $coutFluide, formatter: formatter)
                            Text("€/H")
                        }
                    }
                    VStack{
                        Text("Personnel").bold()
                        HStack{
                            TextField("",value : $coutPersonnel, formatter: formatter)
                            Text("€/H")
                        }
                    }
                }
                Text("Coût des charges : \(cc,specifier:"%.2f") €")
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.cyan,lineWidth: 2)
            )
            .foregroundColor(Color.cyan)
            .background(Color.white)
            VStack{
                Toggle("Calcul avec les charges",isOn: $charge)
                Text("Coût de production : \(cp,specifier:"%.2f") €")
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.green,lineWidth: 2)
            )
            .foregroundColor(Color.green)
            .background(Color.white)
            
        }
        .foregroundColor(Color.red)
        
    }
}
