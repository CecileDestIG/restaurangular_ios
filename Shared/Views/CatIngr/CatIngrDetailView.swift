//
//  CatIngrDetailView.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 19/02/2022.
//

import Foundation
import SwiftUI

struct CatIngrDetailView : View {
    @ObservedObject var catingrVM : CatIngrVM
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentCI : IntentCatIngr
    
    init(civm : CatIngrVM, cilvm:CatIngrListVM ){
        self.catingrVM=civm
        self.intentCI=IntentCatIngr()
        self.intentCI.addObserver(civm: civm)
        self.intentCI.addObserver(cilvm: cilvm)

    }
    
    var body : some View {
        VStack{
            HStack{
                Text("Nom categorie ingredient : ");
                TextField("modele", text: $catingrVM.nom_cat_ingr)
                    .onSubmit {
                        intentCI.intentToChange(nom_cat_ingr: catingrVM.nom_cat_ingr)
                    }
            }
            Spacer()
        }.padding()
    }
}
