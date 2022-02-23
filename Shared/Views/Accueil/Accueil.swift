//
//  Accueil.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct Accueil: View {
    
    /*
    @StateObject var listeRecette = RecetteListVM(rlist: [
        Recette(id_recette: 1, id_createur: 1, nom_recette: "Bretzel", nb_couvert: 4, id_categorie: 1, prix_vente: 2.5, etapes: [
            Etape(id_etape: 2, titre_etape: "Bretzel forme", temps_etape: 5, description_etape: "faire un boudin puis le replier comme des bras croisés"),
            Etape(id_etape: 3, titre_etape: "Bretzel pate", temps_etape: 5, description_etape: "mettre tous les ingredients dans le bol et melanger")], recinclus: [], ingredients: [Ingredient(id_ingredient: 1, nom_ingredient: "carotte", unite: "kg", cout_unitaire: 2.5, stock: 12, id_cat_ingr: 1, id_allergene: 0, allergene : " ", nom_cat_ingr: " "),Ingredient(id_ingredient: 2, nom_ingredient: "poire", unite: "kg", cout_unitaire: 2.5, stock: 12, id_cat_ingr: 1, id_allergene: 0, allergene : " ", nom_cat_ingr: " "),])
    ])*/
    
    var body: some View {
        NavigationView{
            VStack{
                /*
                List {
                    ForEach(listeRecette.rList, id:\.id_recette){item in
                        NavigationLink(destination: RecetteDetailView(rvm: RecetteVM(r: item), rlvm: self.listeRecette)){
                            VStack(alignment: .leading){
                                Text(item.nom_recette)
                            
                            }
                        }.navigationTitle("recette")
                    }
                }*/
            }
        }
    }
}

struct Accueil_Previews: PreviewProvider {
    static var previews: some View {
        Accueil()
    }
}
