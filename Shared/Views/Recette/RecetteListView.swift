//
//  RecetteListView.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 24/02/2022.
//

import SwiftUI

struct RecetteListView: View {
    
    @StateObject var recetteList : RecetteListVM = RecetteListVM()
    
    var body: some View {
        NavigationView{
            
            
            
            
            
            
            
            
            
            
            
            // Liste Recette
            List {
                ForEach(recetteList.recette_list, id:\.id_recette){item in
                    NavigationLink(destination: RecetteDetailView(rvm: RecetteVM(r: item), rlvm: self.recetteList)){
                        VStack(alignment: .leading){
                            Text(item.nom_recette)
                        }
                    }
                }
            }
            .navigationTitle("Recettes")
            .task{
                // RECETTES
                if let list = await RecetteDAO.getAllRecette(){
                    self.recetteList.recette_list = list
                    print("Recette list : ",list)
                }
            }
        }
    }
}

struct RecetteListView_Previews: PreviewProvider {
    static var previews: some View {
        RecetteListView()
    }
}
