//
//  IngredientDetailView.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 19/02/2022.
//

import Foundation
import SwiftUI

struct IngredientDetailView : View {
    @ObservedObject var ingredientVM : IngredientVM
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentI : IntentIngredient
    @StateObject var listeAllergene : AllergeneListVM = AllergeneListVM()
    @StateObject var listeCatIngr : CatIngrListVM = CatIngrListVM()
    
    init(ivm : IngredientVM, ilvm:IngredientListVM ){
        self.ingredientVM=ivm
        self.intentI=IntentIngredient()
        self.intentI.addObserver(ivm: ivm)
        self.intentI.addObserver(ilvm: ilvm)

    }
    
    var body : some View {
        VStack{
            Text("\(ingredientVM.nom_ingredient)").font(.largeTitle).bold()
            Form{
            HStack{
                Text("Nom ingredient : ");
                TextField("nom", text: $ingredientVM.nom_ingredient)
                    .onSubmit {
                        intentI.intentToChange(nom_ingredient: ingredientVM.nom_ingredient)
                    }
            }
                HStack{
                Text("unite : ");
                TextField("unité", text: $ingredientVM.unite)
                    .onSubmit {
                        intentI.intentToChange(unite: ingredientVM.unite)
                    }
                }
                HStack{
                Text("cout_unitaire : ");
                TextField("cout unitaire", value: $ingredientVM.cout_unitaire, formatter: NumberFormatter())
                    .onSubmit {
                        intentI.intentToChange(cout_unitaire: ingredientVM.cout_unitaire)
                    }
                }
            HStack{
                Text("stock : ");
                TextField("stock", value: $ingredientVM.stock, formatter: NumberFormatter())
                    .onSubmit {
                        intentI.intentToChange(stock: ingredientVM.stock)
                    }
            }
            HStack{
                Picker("Catégorie :", selection: $ingredientVM.id_cat_ingr) {
                    ForEach(listeCatIngr.cat_ingr_list, id:\.id_cat_ingr){item in
                        Text(item.nom_cat_ingr)
                    }
                }
            }
            HStack{
                Picker("Allergne :", selection: $ingredientVM.id_allergene) {
                    ForEach(listeAllergene.allergeneList, id:\.id_allergene){item in
                        Text(item.nom_allergene)
                    }
                }
            }
            }
            Spacer()
        }.padding()
            .task{
                //ALLERGENE
                if let list = await AllergeneDAO.allergeneGetAll(){
                    self.listeAllergene.allergeneList = list
                }
                if let list = await CatIngrDAO.getAllCatIngr(){
                    self.listeCatIngr.cat_ingr_list = list
                }
            }
    }
}
