//
//  CatIngrCreationView.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 26/02/2022.
//

import Foundation
import SwiftUI

struct CatIngrCreationView : View {
    
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentCI : IntentCatIngr
    @State var catingrcreate : CatIngrDTO = CatIngrDTO(nom_cat_ingr: "")
    
    init( cilvm:CatIngrListVM ){
        self.intentCI=IntentCatIngr()
        self.intentCI.addObserver(cilvm: cilvm)
    }
    
    var body : some View {
        VStack{
            Form{
                HStack{
                    TextField("nom cat ingr : ", text : $catingrcreate.nom_cat_ingr)
                }
                Button("nouvelle cat ingr"){
                    Task{
                        await CatIngrDAO.createCatIngr(nom_cat_ingr: catingrcreate.nom_cat_ingr)
                    }
                }
            }
        }.padding()
    }
}
