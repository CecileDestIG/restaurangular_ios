//
//  CategorieCreateView.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 02/03/2022.
//

import SwiftUI

import Foundation
import SwiftUI

struct CategorieCreateView : View {
    
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentCat : IntentCategorie
    @State var catcreate : CategorieDTO = CategorieDTO( nom_categorie: "")
    
    init(clvm:CategorieListVM ){
        self.intentCat=IntentCategorie()
        self.intentCat.addObserver(clvm: clvm)
    }
    
    var body : some View {
        VStack{
            Text("Création Catégorie").font(.largeTitle).bold()
            Form{
                HStack{
                    TextField("Nom Catégorie : ", text : $catcreate.nom_categorie)
                }
                HStack{
                    Spacer()
                    Button("Enregistrer"){
                        Task{
                            await intentCat.intentToCreate(nom_categorie: catcreate.nom_categorie)
                        }
                    }
                    Spacer()
                }
            }
        }.padding()
    }
}
