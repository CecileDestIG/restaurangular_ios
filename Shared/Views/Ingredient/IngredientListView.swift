//
//  IngredientListView.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct IngredientListView: View {
    
    @StateObject var ingredientList : IngredientListVM = IngredientListVM()
    
    var body: some View {
        NavigationView{
            // Liste Ingredient
            List {
                ForEach(ingredientList.ingredient_list, id:\.id_ingredient){item in
                    NavigationLink(destination: IngredientDetailView(ivm: IngredientVM(i: item), ilvm: self.ingredientList)){
                        VStack(alignment: .leading){
                            Text(item.nom_ingredient)
                        }
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
            }
        }
    }
}

struct IngredientListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListView()
    }
}
