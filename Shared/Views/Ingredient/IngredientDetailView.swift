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
    let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
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
            }
                HStack{
                Text("unite : ");
                TextField("unité", text: $ingredientVM.unite)
                }
                HStack{
                Text("cout_unitaire : ");
                TextField("cout unitaire", value: $ingredientVM.cout_unitaire, formatter: formatter)
                }
            HStack{
                Text("stock : ");
                TextField("stock", value: $ingredientVM.stock, formatter:formatter)
            }
                Picker("Catégorie : ", selection: $ingredientVM.id_cat_ingr) {
                    ForEach(listeCatIngr.cat_ingr_list, id:\.id_cat_ingr){item in
                        Text(item.nom_cat_ingr)
                    }
                }
                NavigationLink(destination: CatIngrCreationView(cilvm: self.listeCatIngr)){
                Button("+ Cat Ingredient"){}
            }
                Picker("Allergène : ", selection: $ingredientVM.id_allergene) {
                    ForEach(listeAllergene.allergeneList, id:\.id_allergene){item in
                        List{
                        Text(item.nom_allergene)
                        }
                    }
            }
                    NavigationLink(destination: AllergeneCreationView(alvm: self.listeAllergene)){
                    Button("+ Allergène"){}
                }
                HStack{
                    Spacer()
                    Button("modifier"){
                        Task{
                            await intentI.intentToChange(ingredient: ingredientVM)
                        }
                    }
                    Spacer()
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
