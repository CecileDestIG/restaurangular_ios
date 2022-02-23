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
            Accueil().tabItem{
                Text("Accueil")
            }.tag(1)
            IngredientListView().tabItem{
                Text("Ingrédients")
            }.tag(2)
            CatIngrListView().tabItem{
                Text("Cat. Ingrédient")
            }.tag(3)
            EtapeListView().tabItem{
                Text("Etapes")
            }.tag(4)
            AllergeneListView().tabItem{
                Text("Allergènes")
            }.tag(5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
