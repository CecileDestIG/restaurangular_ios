//
//  CategorieDetailView.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 03/03/2022.
//
import Foundation

import SwiftUI

struct CategorieDetailView: View {
    @ObservedObject var catVM : CategorieVM
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentC : IntentCategorie
    
    init(cvm : CategorieVM, clvm:CategorieListVM ){
        self.catVM=cvm
        self.intentC=IntentCategorie()
        self.intentC.addObserver(cvm: cvm)
        self.intentC.addObserver(clvm: clvm)

    }
    
    var body: some View {
        VStack{
            Text("\(catVM.nom_categorie)").font(.largeTitle).bold()
            Form{
            HStack{
                Text("Categorie : ");
                TextField("modele", text: $catVM.nom_categorie)
                    .onSubmit {
                        Task{
                            await intentC.intentToChange(categorie: catVM)
                        }
                    }
                }}
            Spacer()
        }.padding()
    }
}

