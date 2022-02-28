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
            Text("\(catingrVM.nom_cat_ingr)").font(.largeTitle).bold()
            Form{
            HStack{
                Text("Categorie : ");
                TextField("modele", text: $catingrVM.nom_cat_ingr)
                    .onSubmit {
                        Task{
                            await intentCI.intentToChange(catingr: catingrVM)
                        }
                    }
                }}
            Spacer()
        }.padding()
    }
}
