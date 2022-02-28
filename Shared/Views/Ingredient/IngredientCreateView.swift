//
//  IngredientCreate.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 28/02/2022.
//

import Foundation
import SwiftUI

struct IngredientCreationView : View {
    @ObservedObject var ingredientVM : IngredientVM = IngredientVM(i: Ingredient())
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentI : IntentIngredient
    @StateObject var listeAllergene : AllergeneListVM = AllergeneListVM()
    @StateObject var listeCatIngr : CatIngrListVM = CatIngrListVM()
    
    init(ilvm:IngredientListVM ){
        self.intentI=IntentIngredient()
        self.intentI.addObserver(ilvm: ilvm)

    }
    
    var body : some View {
        VStack{
            Text("Création Ingredient").font(.largeTitle).bold()
            Form{
            HStack{
                Text("Nom ingredient : ");
                TextField("modele", text: $ingredientVM.nom_ingredient)
            }
            HStack{
                Text("unite : ");
                TextField("modele", text: $ingredientVM.unite)
            }
            HStack{
                Text("cout_unitaire : ");
                TextField("modele", value: $ingredientVM.cout_unitaire, formatter: NumberFormatter())
            }
            HStack{
                Text("stock : ");
                TextField("modele", value: $ingredientVM.stock, formatter: NumberFormatter())
            }
                Picker("Catégorie : ", selection: $ingredientVM.id_cat_ingr) {
                    ForEach(listeCatIngr.cat_ingr_list, id:\.id_cat_ingr){item in
                        Text(item.nom_cat_ingr)
                    }
                }
                Picker("Allergne : ", selection: $ingredientVM.id_allergene) {
                    ForEach(listeAllergene.allergeneList, id:\.id_allergene){item in
                        Text(item.nom_allergene)
                    }
                
            }
                HStack{
                    Spacer()
                    Button("nouvel ingr"){
                        Task{
                            await IngredientDAO.createIngredient(ingredient: ingredientVM)
                        }
                    }
                    Spacer()
                }
            }
            Spacer()
        }
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
