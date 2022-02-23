//
//  ContentView.swift
//  Shared
//
//  Created by Ingrid on 19/02/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var listeAllergene = AllergeneListVM(allergenelist: [
        Allergene(id_allergene: 1, nom_allergene: "lactose"),
        Allergene(id_allergene: 2, nom_allergene: "fruits a coque"),
        Allergene(id_allergene: 3, nom_allergene: "poisson"),
        Allergene(id_allergene: 4, nom_allergene: "crustacés")
    ])
    
    @StateObject var listeCI : CatIngrList = CatIngrList()
    
    
    @StateObject var listeIngredient = IngredientListVM(ilist: [
        Ingredient(id_ingredient: 1, nom_ingredient: "carotte", unite: "kg", cout_unitaire: 2.5, stock: 12, id_cat_ingr: 1, id_allergene: 0, allergene : " ", nom_cat_ingr: " "),
        Ingredient(id_ingredient: 2, nom_ingredient: "poire", unite: "kg", cout_unitaire: 2.5, stock: 12, id_cat_ingr: 1, id_allergene: 0, allergene : " ", nom_cat_ingr: " "),
        Ingredient(id_ingredient: 3, nom_ingredient: "Concombre", unite: "kg", cout_unitaire: 2.5, stock: 12, id_cat_ingr: 1, id_allergene: 0, allergene : " ", nom_cat_ingr: " ")
    ])
    
    @StateObject var listeEtape = EtapeListVM(elist: [
        Etape(id_etape: 1, titre_etape: "Blanc en neige", temps_etape: 5, description_etape: "mettre les blancs dans un bol et les battre"),
        Etape(id_etape: 2, titre_etape: "Bretzel forme", temps_etape: 5, description_etape: "faire un boudin puis le replier comme des bras croisés"),
        Etape(id_etape: 3, titre_etape: "Bretzel pate", temps_etape: 5, description_etape: "mettre tous les ingredients dans le bol et melanger")
    ])
    
    @StateObject var listeRecette = RecetteListVM(rlist: [
        Recette(id_recette: 1, id_createur: 1, nom_recette: "Bretzel", nb_couvert: 4, id_categorie: 1, prix_vente: 2.5, etapes: [
            Etape(id_etape: 2, titre_etape: "Bretzel forme", temps_etape: 5, description_etape: "faire un boudin puis le replier comme des bras croisés"),
            Etape(id_etape: 3, titre_etape: "Bretzel pate", temps_etape: 5, description_etape: "mettre tous les ingredients dans le bol et melanger")], recinclus: [], ingredients: [Ingredient(id_ingredient: 1, nom_ingredient: "carotte", unite: "kg", cout_unitaire: 2.5, stock: 12, id_cat_ingr: 1, id_allergene: 0, allergene : " ", nom_cat_ingr: " "),Ingredient(id_ingredient: 2, nom_ingredient: "poire", unite: "kg", cout_unitaire: 2.5, stock: 12, id_cat_ingr: 1, id_allergene: 0, allergene : " ", nom_cat_ingr: " "),])
    ])
    
    var body: some View {
        NavigationView{
            VStack{/*
                List {
                    ForEach(listeAllergene.allergeneList, id:\.id_allergene){item in
                        NavigationLink(destination: AllergeneDetailView(avm: AllergeneVM(allergene: item), alvm: self.listeAllergene)){
                            VStack(alignment: .leading){
                                Text(item.nom_allergene)
                            
                            }
                        }.navigationTitle("Allergene")
                    }
                }*/
                List {
                    ForEach(listeCI.cat_ingr_list, id:\.id_cat_ingr){item in
                            VStack(alignment: .leading){
                                Text(item.nom_cat_ingr)
                            }
                        }.navigationTitle("CI")
                    }
                }
            .task {
                if let list = await CatIngrDAO.getAllCatIngr(){
                    self.listeCI.cat_ingr_list = list
                    print("Content list : ",list)
                }
            }/*
                List {
                    ForEach(listeIngredient.iList, id:\.id_ingredient){item in
                        NavigationLink(destination: IngredientDetailView(ivm: IngredientVM(i: item), ilvm: self.listeIngredient)){
                            VStack(alignment: .leading){
                                Text(item.nom_ingredient)
                            
                            }
                        }.navigationTitle("Ingredient")
                    }
                }
                List {
                    ForEach(listeEtape.eList, id:\.id_etape){item in
                        NavigationLink(destination: EtapeDetailView(evm: EtapeVM(e: item), elvm: self.listeEtape)){
                            VStack(alignment: .leading){
                                Text(item.titre_etape)
                            
                            }
                        }.navigationTitle("Etape")
                    }
                }
                List {
                    ForEach(listeRecette.rList, id:\.id_recette){item in
                        NavigationLink(destination: RecetteDetailView(rvm: RecetteVM(r: item), rlvm: self.listeRecette)){
                            VStack(alignment: .leading){
                                Text(item.nom_recette)
                            
                            }
                        }.navigationTitle("recette")
                    }
                }*/

                Spacer()
                
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
