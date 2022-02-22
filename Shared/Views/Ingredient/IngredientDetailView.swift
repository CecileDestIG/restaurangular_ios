//
//  IngredientDetailView.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 19/02/2022.
//

import Foundation
import SwiftUI

struct IngredientDetailView : View {
    @ObservedObject var ingredientVM : IngredientVM
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentI : IntentIngredient
    
    init(ivm : IngredientVM, ilvm:IngredientListVM ){
        self.ingredientVM=ivm
        self.intentI=IntentIngredient()
        self.intentI.addObserver(ivm: ivm)
        self.intentI.addObserver(ilvm: ilvm)

    }
    
    var body : some View {
        VStack{
            HStack{
                Text("Nom ingredient : ");
                TextField("modele", text: $ingredientVM.nom_ingredient)
                    .onSubmit {
                        intentI.intentToChange(nom_ingredient: ingredientVM.nom_ingredient)
                    }
            }
                HStack{
                Text("unite : ");
                TextField("modele", text: $ingredientVM.unite)
                    .onSubmit {
                        intentI.intentToChange(unite: ingredientVM.unite)
                    }
                }
                HStack{
                Text("cout_unitaire : ");
                TextField("modele", value: $ingredientVM.cout_unitaire, formatter: NumberFormatter())
                    .onSubmit {
                        intentI.intentToChange(cout_unitaire: ingredientVM.cout_unitaire)
                    }
                }
            HStack{
                Text("stock : ");
                TextField("modele", value: $ingredientVM.stock, formatter: NumberFormatter())
                    .onSubmit {
                        intentI.intentToChange(stock: ingredientVM.stock)
                    }
            }
            HStack{
                Text("id_cat_ingr : ");
                TextField("modele", value: $ingredientVM.id_cat_ingr, formatter: NumberFormatter())
                    .onSubmit {
                        intentI.intentToChange(id_cat_ingr: ingredientVM.id_cat_ingr)
                    }
            }
            HStack{
                Text("id_allergene : ");
                TextField("modele", value: $ingredientVM.id_allergene, formatter: NumberFormatter())
                    .onSubmit {
                        intentI.intentToChange(id_allergene: ingredientVM.id_allergene)
                    }
            }
            Spacer()
        }.padding()
    }
}
