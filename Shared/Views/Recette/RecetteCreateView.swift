//
//  RecetteCreateView.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 02/03/2022.
//

import SwiftUI
import Foundation

struct RecetteCreateView: View {
    
    @ObservedObject var recetteVM : RecetteVM = RecetteVM(r: Recette())
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentR : IntentRecette
    @StateObject var listeIngr : IngredientListVM = IngredientListVM()
    @StateObject var listeCat : CategorieListVM = CategorieListVM()
    @StateObject var listeEtape : EtapeListVM = EtapeListVM()
    @State var listeRecette : RecetteListVM
    let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var recettes : [RecetteVM] = []
    @State var etapeSelect : EtapeVM = EtapeVM(e: Etape())
    @State var etapes : [EtapeVM] = []
    
    init(rlvm:RecetteListVM ){
        self.intentR=IntentRecette()
        self.intentR.addObserver(rlvm: rlvm)
        self.listeRecette=rlvm

    }
    
    var body : some View {
        VStack{
            Text("Création Recette").font(.largeTitle).bold()
            Form{
                HStack{
                    Text("Nom Recette : ");
                    TextField("nom", text: $recetteVM.nom_recette)
                }
                HStack{
                    Text("Nombre Couvert : ");
                    TextField("couverts", value: $recetteVM.nb_couvert, formatter:formatter)
                }
                HStack{
                    Text("Prix de Vente : ");
                    TextField("prix", value: $recetteVM.prix_vente, formatter:formatter)
                }
                Picker("Catégorie : ", selection: $recetteVM.id_categorie) {
                    ForEach(listeCat.categorie_list, id:\.id_categorie){item in
                        Text(item.nom_categorie)
                    }
                }
                NavigationLink(destination: CategorieCreateView(clvm: self.listeCat)){
                    Button("+ Categorie"){}
                }
                Section{
                    Picker("Etapes : +", selection: $etapeSelect) {
                        ForEach(listeEtape.etape_list, id:\.id_etape){item in
                            List{
                                HStack{
                                    Text("\(item.titre_etape)")
                                    Button(action: {etapes.append(EtapeVM(e:item))}, label:{Text("+")})
                                }
                            }
                        }
                    }
                    //pour afficher la liste des etapes selectionnees
                    ForEach(etapes, id:\.self){item in
                        List{
                            Text(item.titre_etape)
                        }
                    }
                
                    //pour creer une nouvelle etape
                    NavigationLink(destination: EtapeCreateView(elvm: self.listeEtape)){
                        Button("+ Etape"){}
                    }
                    
                }
                HStack{
                    Spacer()
                    Button("Ajouter Recette"){
                        Task{
                            //await intentR.intentToCreate(recette : recetteVM)
                        }
                    }
                    Spacer()
                }
            }
            Spacer()
        }
        .task{
            //ALLERGENE
            if let list = await EtapeDAO.getAllEtape(){
                self.listeEtape.etape_list = list
            }
            if let list = await IngredientDAO.getAllIngredient(){
                self.listeIngr.ingredient_list = list
            }
            if let list = await CategorieDAO.getAllCategorie(){
                self.listeCat.categorie_list = list
            }
        }
    }
}

