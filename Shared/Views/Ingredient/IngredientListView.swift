//
//  IngredientListView.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct IngredientListView: View {
    
    @StateObject var ingredientList : IngredientListVM = IngredientListVM()
    @StateObject var listeCatIngr : CatIngrListVM = CatIngrListVM()
    
    @State var searchText = ""
    
    var searchResults : [Ingredient] {
        if searchText.isEmpty {
            return ingredientList.ingredient_list
        }
        else{
            return ingredientList.ingredient_list.filter { $0.nom_ingredient.uppercased().contains(searchText.uppercased())}
        }
    }
    
    var body: some View {
        
        NavigationView{
            // Liste Ingredient
            List {
                ForEach(listeCatIngr.cat_ingr_list.sorted{ $0.nom_cat_ingr < $1.nom_cat_ingr }, id:\.id_cat_ingr){section in
                    Section(header: Text("\(section.nom_cat_ingr)")){
                        ForEach(searchResults.sorted{$0.nom_ingredient < $1.nom_ingredient},id:\.id_ingredient){ item in
                            if(item.nom_cat_ingr == section.nom_cat_ingr){
                                NavigationLink(destination: IngredientDetailView(ivm: IngredientVM(i: item), ilvm: self.ingredientList)){
                                    Text("\(item.nom_ingredient)")
                                }
                            }
                        }
                        .searchable(text: $searchText)
                    }
                }
            }
            .navigationTitle("Ingrédients")
            .task{
                // INGREDIENTS
                if let list = await IngredientDAO.getAllIngredient(){
                    self.ingredientList.ingredient_list = list
                    print("Content list : ",list)
                }
                // CATEGORIES INGREDIENT
                if let list = await CatIngrDAO.getAllCatIngr(){
                    self.listeCatIngr.cat_ingr_list = list
                    print("Content list : ",list)
                }
            }
        }
    }
}

struct IngredientListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListView()
    }
}
