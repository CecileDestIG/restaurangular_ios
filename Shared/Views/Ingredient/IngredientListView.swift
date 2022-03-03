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
    
    @State var searchTextIngr = ""
    
    var searchResultsIngredient : [Ingredient] {
        if searchTextIngr.isEmpty {
            return ingredientList.ingredient_list
        }
        else{
            return ingredientList.ingredient_list.filter { $0.nom_ingredient.uppercased().contains(searchTextIngr.uppercased())}
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink(destination:IngredientCreationView(ilvm: ingredientList)){
                        Text("Nouvel ingrédient")
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
                    .foregroundColor(.white)
                    NavigationLink(destination:CatIngrCreationView(cilvm:listeCatIngr)){
                        Text("Nouvelle catégorie")
                    }
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(5)
                    .foregroundColor(.white)
                }
                // Liste Ingredient
                List {
                    ForEach(self.listeCatIngr.cat_ingr_list, id:\.id_cat_ingr){
                        section in
                        Section(header: Text("\(section.nom_cat_ingr)"),footer: NavigationLink(destination:(CatIngrDetailView(civm: CatIngrVM(ci: section), cilvm: self.listeCatIngr))){Text("Modifier la categorie")}.foregroundColor(Color.blue)){
                            ForEach(self.searchResultsIngredient,id:\.id_ingredient){
                                item in
                                if(item.nom_cat_ingr == section.nom_cat_ingr){
                                    VStack{
                                        NavigationLink(destination: IngredientDetailView(ivm: IngredientVM(i: item), ilvm: self.ingredientList)){
                                            IngrView(ingredient:item)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .searchable(text: $searchTextIngr)
                .navigationTitle("Stock")
                .task{
                    // INGREDIENTS
                    if let list = await IngredientDAO.getAllIngredient(){
                        self.ingredientList.ingredient_list = list.sorted{$0.nom_ingredient < $1.nom_ingredient}
                        print("Content list : ",list)
                    }
                    // CATEGORIES INGREDIENT
                    if let list = await CatIngrDAO.getAllCatIngr(){
                        self.listeCatIngr.cat_ingr_list = list.sorted{ $0.nom_cat_ingr < $1.nom_cat_ingr }
                        print("Content list : ",list)
                    }
                }
            }
        }
    }
}

struct IngrView: View {
    let ingredient : Ingredient
    var body : some View {
        HStack{
            Text("\(ingredient.nom_ingredient) (\(ingredient.stock,specifier: "%.2f")\(ingredient.unite))")
        }
    }
}

struct IngredientListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListView()
    }
}
