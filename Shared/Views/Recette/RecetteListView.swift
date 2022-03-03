//
//  RecetteListView.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 24/02/2022.
//

import SwiftUI

struct RecetteListView: View {
    
    @StateObject var recetteList : RecetteListVM = RecetteListVM()
    @StateObject var categorieList : CategorieListVM = CategorieListVM()
    
    @State var searchTextRecette = ""
    
    var searchResultsRecette : [Recette] {
        if searchTextRecette.isEmpty {
            return recetteList.recette_list
        }
        else{
            return recetteList.recette_list.filter { $0.nom_recette.uppercased().contains(searchTextRecette.uppercased())}
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink(destination:RecetteCreateView()){
                        Text("Nouvelle recette")
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
                    .foregroundColor(.white)
                    NavigationLink(destination:CategorieCreateView(clvm: categorieList)){
                        Text("Nouvelle catégorie")
                    }
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(5)
                    .foregroundColor(.white)
                }
                // Liste Recette
                List {
                    ForEach(self.categorieList.categorie_list, id:\.id_categorie){
                        section in
                        Section(header: Text("\(section.nom_categorie)"),footer: NavigationLink(destination:(CategorieDetailView())){Text("Modifier la categorie")}.foregroundColor(Color.blue)){
                            ForEach(self.searchResultsRecette,id:\.id_recette){
                                item in
                                if(item.nom_categorie == section.nom_categorie){
                                    VStack{
                                        NavigationLink(destination: RecetteDetailView(rvm: RecetteVM(r: item), rlvm: self.recetteList)){
                                            RecetteView(recette:item)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .searchable(text: $searchTextRecette)
                .navigationTitle("Recettes")
                .task{
                    //  RECETTES
                    if let list = await RecetteDAO.getAllRecette(){
                        self.recetteList.recette_list = list.sorted{$0.nom_recette < $1.nom_recette}
                        print("Recette list : ",list)
                    }
                    // CATEGORIES
                    if let list = await CategorieDAO.getAllCategorie(){
                        self.categorieList.categorie_list = list.sorted{ $0.nom_categorie < $1.nom_categorie }
                        print("Categorie list : ",list)
                    }
                }
            }
        }
    }
}

struct RecetteView: View {
    let recette : Recette
    var body : some View {
        HStack{
            Text("\(recette.nom_recette) (\(recette.nb_couvert) pers.)")
        }
    }
}

struct RecetteListView_Previews: PreviewProvider {
    static var previews: some View {
        RecetteListView()
    }
}
