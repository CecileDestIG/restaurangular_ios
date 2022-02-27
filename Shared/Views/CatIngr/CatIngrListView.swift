//
//  CatIngrListView.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct CatIngrListView: View {
    
    @StateObject var listeCatIngr : CatIngrListVM = CatIngrListVM()
    
    var body: some View {
        NavigationView{
            // Liste categorie ingredient
            VStack{
            List {
                ForEach(listeCatIngr.cat_ingr_list, id:\.id_cat_ingr){item in
                    NavigationLink(destination: CatIngrDetailView(civm: CatIngrVM(ci: item), cilvm: self.listeCatIngr)){
                        VStack(alignment: .leading){
                            Text(item.nom_cat_ingr)
                        }
                    }
                }
            }
            NavigationLink(destination: CatIngrCreationView(cilvm: listeCatIngr)){
                Text("nouvelle cat ingr")
            }
            }
            .navigationTitle("Cat. d'ingrédient")
            .task{
                // CATEGORIES INGREDIENT
                if let list = await CatIngrDAO.getAllCatIngr(){
                    self.listeCatIngr.cat_ingr_list = list
                }
            }
        }
    }
}

struct CatIngrListView_Previews: PreviewProvider {
    static var previews: some View {
        CatIngrListView()
    }
}
