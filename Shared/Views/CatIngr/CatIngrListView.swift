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
            List {
                ForEach(listeCatIngr.cat_ingr_list.sorted{$0.nom_cat_ingr < $1.nom_cat_ingr}, id:\.id_cat_ingr){item in
                    NavigationLink(destination: CatIngrDetailView(civm: CatIngrVM(ci: item), cilvm: self.listeCatIngr)){
                        VStack(alignment: .leading){
                            Text(item.nom_cat_ingr)
                        }
                    }
                }
                }
            .navigationTitle("Cat. d'ingrédient")
            .task{
                // CATEGORIES INGREDIENT
                if let list = await CatIngrDAO.getAllCatIngr(){
                    self.listeCatIngr.cat_ingr_list = list
                    print("Content list : ",list)
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
