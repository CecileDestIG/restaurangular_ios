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
    
    @State var etapeSelect : EtapeVM = EtapeVM(e: Etape())
    @State var etapes : [EtapeVM] = []
    @State var etincluses : [EtapeInclusCreate] = []
    @State var etDTO : [EtapeCreateRecetteDTO] = []
    
    @State var recetteSelect : RecetteVM = RecetteVM(r: Recette())
    @State var i = 0
    @State var recincluses : [RecetteInclAffiche] = []
    @State var recDTO : [RecetteInclusCreateDTO] = []

    @State var ingredientSelect : IngredientVM = IngredientVM(i: Ingredient())
    @State var ingrDTO : [IngredientCreateRecetteDTO] = []
    @State var ingrinclus : [IngredientCreateInclus] = []

    init(rlvm:RecetteListVM ){
        self.intentR=IntentRecette()
        self.intentR.addObserver(rlvm: rlvm)
        self.listeRecette=rlvm

    }
    
    var body : some View {
        VStack{
            Text("Création Recette").font(.largeTitle).bold()
            Form{
                Group{
                    HStack{
                        Text("Nom Recette : ");
                        TextField("nom", text: $recetteVM.nom_recette)
                    }
                    HStack{
                        Text("Image : ");
                        TextField("URL de l'image", text: $recetteVM.image)
                        AsyncImage(url: URL(string:recetteVM.image),content: { img in
                            img
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .scaledToFit()
                            .cornerRadius(5)
                            .padding()
                        },placeholder: {
                            ProgressView()
                        })
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
                        Button("Nouvelle Categorie"){}
                    }
                }
                Group{
                    Section{
                        Picker("Ingredients : +", selection: $ingredientSelect) {
                            Text("Modifier la quantité de l'ingrédient : ")
                            ForEach($ingrinclus, id:\.id_ingredient){item in
                                HStack{
                                Text("Quantite : ")
                                TextField("quantite", value: item.quantite_necessaire, formatter:formatter)
                                TextField("nom", text:item.nom_ingredient)
                                }
                            }
                            Text("Selectionner les ingrédients :")
                            ForEach(listeIngr.ingredient_list, id:\.id_ingredient){item in
                                List{
                                    HStack{
                                        Text("\(item.nom_ingredient)")
                                        Spacer()
                                        Button(action: {
                                            ingrinclus.append(IngredientCreateInclus(id_ingredient: item.id_ingredient, quantite:0, nom: item.nom_ingredient, unite: item.unite))
                                        }, label:{Text("+")})
                                    }
                                    }
                                }
                            
                            }
                        
                        //pour afficher la liste des etapes selectionnees
                        ForEach(ingrinclus.indices, id:\.self){item in
                            List{
                                VStack(alignment : .leading){
                                    HStack{
                                Text("\(ingrinclus[item].nom_ingredient) : \(ingrinclus[item].quantite_necessaire,specifier: "%.2f") \(ingrinclus[item].unite) ")
                                        Spacer()
                                    Button(action : {
                                        ingrinclus.remove(at: item)
                                    },label:{Text("-")})
                                    }
                                }
                            }
                            
                        }
                    
                        //pour creer une nouvelle etape
                        NavigationLink(destination: IngredientCreationView(ilvm: self.listeIngr)){
                            Button("Nouvel Ingredient"){}
                        }
                    }
                }
                Group{
                //section pour ajout, creation choix etapes
                    Section{
                        Picker("Etapes : +", selection: $etapeSelect) {
                            Text("Modifier la place de l'étape incluse dans la recette : ")
                            ForEach($etincluses, id:\.id_etape){item in
                                HStack{
                                Text("place : ")
                                TextField("N° place", value: item.place_et, formatter:formatter)
                                TextField("titre", text:item.titre_etape)
                                }
                            }
                            Text("Selectionner les étapes : ")
                            ForEach(listeEtape.etape_list, id:\.id_etape){item in
                                List{
                                    HStack{
                                        Text("\(item.titre_etape)")
                                        Spacer()
                                        Button(action: {
                                            print(item.titre_etape)
                                            i+=1
                                            print("i : \(i)")
                                            etincluses.append(EtapeInclusCreate(id_etape : item.id_etape, place_et:i, titre_etape : item.titre_etape, temps_etape : item.temps_etape, description_etape : item.description_etape))
                                            //recettesincluses[RecetteVM(r:item)]=i
                                        }, label:{Text("+")})
                                    }
                                    }
                            }
                            
                            }
                        
                        //pour afficher la liste des etapes selectionnees
                        ForEach(etincluses.indices, id:\.self){item in
                            List{
                                VStack(alignment : .leading){
                                    HStack{
                                        Text("\(etincluses[item].place_et). ")
                                        Text(etincluses[item].titre_etape)
                                        Spacer()
                                    Button(action : {
                                        etincluses.remove(at: item)
                                    },label:{Text("-")})
                                    }
                                    Text(etincluses[item].description_etape)
                                }
                               
                            }
                        }
                    
                        //pour creer une nouvelle etape
                        NavigationLink(destination: EtapeCreateView(elvm: self.listeEtape)){
                            Button("Nouvelle Etape"){}
                        }
                    
                }
                }
                Group{
                    Section{
                    //section ajout, choix, selection recettes incluses
                        Picker("Recettes à inclures : +", selection: $recetteSelect) {
                            Text("Modifier la place de la recette incluse dans la recette : ")
                            ForEach($recincluses, id:\.id){item in
                                HStack{
                                Text("place : ")
                                TextField("N° place", value: item.place_rec, formatter:formatter)
                                TextField("titre", text:item.titre_recette)
                                }
                            }

                            Text("Selectionner les recettes à inclure : ")
                            ForEach(listeRecette.recette_list, id:\.id_recette){item in
                                List{
                                    HStack{
                                        Text("\(item.nom_recette)")
                                        Spacer()
                                        Button(action: {
                                            print(item.nom_recette)
                                            i+=1
                                            print("i : \(i)")
                                            recincluses.append(RecetteInclAffiche(titre_recette: item.nom_recette, id: item.id_recette, place_rec: i, temps: item.temps_recette, cout:item.cout_production))
                                            //recettesincluses[RecetteVM(r:item)]=i
                                        }, label:{Text("+")})
                                    }
                                }
                            }
            
                
                        }
                        ForEach(recincluses.indices, id:\.self){item in
                        HStack{
                            Text("\(recincluses[item].place_rec). ")
                            Text(recincluses[item].titre_recette)
                            Spacer()
                            Button(action : {
                                recincluses.remove(at: item)
                            },label:{Text("-")})
                        }
                    }
                    }
                    
                }
                    HStack{
                        Spacer()
                        Button("Enregistrer Recette"){
                            Task{
                                ingrinclus.forEach{item in
                                    ingrDTO.append(IngredientCreateRecetteDTO(id_ingredient: item.id_ingredient, quantite_necessaire: item.quantite_necessaire))
                                    print("nb ingr DTO \(ingrDTO.count)")
                                }
                                recincluses.forEach{item in
                                    recDTO.append(RecetteInclusCreateDTO(id_recincl: item.id, place_rec: item.place_rec, temps_recette:item.temps, cout_production:item.cout_production))
                                }
                                etincluses.forEach{item in
                                    etDTO.append(EtapeCreateRecetteDTO(id_etape: item.id_etape, place_et: item.place_et))
                                }
                                await intentR.intentToCreate(recette: recetteVM, recincl: recDTO, etincl: etDTO, ingr: ingrDTO)
                            }
                        }
                        Spacer()
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

}
