//
//  ContentView.swift
//  Shared
//
//  Created by Ingrid on 19/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            RecetteListView(rlvm: RecetteListVM(),clvm: CategorieListVM()).tabItem{
                Image(systemName: "leaf.fill")
                Text("Recettes")
            }.tag(1)
            IngredientListView(ilvm: IngredientListVM(), cilvm: CatIngrListVM()).tabItem{
                Image(systemName: "list.dash")
                Text("Mercuriale")
            }.tag(2)
            AllergeneListView(alvm: AllergeneListVM()).tabItem{
                Image(systemName: "allergens")
                Text("Allergènes")
            }.tag(3)
            EtiquetteListView().tabItem{
                Image(systemName: "barcode")
                Text("Etiquettes")
            }.tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
