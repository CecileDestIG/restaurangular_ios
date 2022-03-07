//
//  RecetteListView.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 24/02/2022.
//

import SwiftUI

struct RecetteListView: View {
    
    @ObservedObject var recetteList : RecetteListVM = RecetteListVM()
    @StateObject var categorieList : CategorieListVM = CategorieListVM()
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentR : IntentRecette
    var intentCat : IntentCategorie
    @State var searchTextRecette = ""
    
    init(rlvm:RecetteListVM, clvm:CategorieListVM ){
        self.intentCat = IntentCategorie()
        self.intentCat.addObserver(clvm: clvm)
        self.intentR=IntentRecette()
        self.intentR.addObserver(rlvm: rlvm)

    }
    
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
                    NavigationLink(destination:RecetteCreateView(rlvm: recetteList)){
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
                        Section(header: Text("\(section.nom_categorie)"),footer: NavigationLink(destination:(CategorieDetailView(cvm: CategorieVM(section), clvm: categorieList))){Text("Modifier la categorie")}.foregroundColor(Color.blue)){
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
                    // RECETTES
                    if let request = await intentR.intentToLoad(){
                        self.recetteList.recette_list = request
                    }
                    // CATEGORIES
                    if let request = await intentCat.intentToLoad(){
                        self.categorieList.categorie_list = request
                    }
                }
            }
        }
    }
}

struct RecetteView: View {
    var intentR : IntentRecette = IntentRecette()
    let recette : Recette
    
    var body : some View {
        HStack(spacing:10){
            if(recette.image != "") {
                AsyncImage(url: URL(string:recette.image),content: { img in
                    img
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75, alignment: .center)
                    .scaledToFit()
                    .cornerRadius(20)
                    .padding()
                },placeholder: {
                    ProgressView()
                })
            }
            else{
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75, alignment: .center)
                    .scaledToFit()
                    .cornerRadius(20)
                    .padding()
            }
            VStack{
                Text("\(recette.nom_recette)")
                    .bold()
                Text("(\(recette.nb_couvert) personnes)")
            }
            .padding()
        }
    }
}

struct RecetteListView_Previews: PreviewProvider {
    static var previews: some View {
        RecetteListView(rlvm: RecetteListVM(),clvm: CategorieListVM())
    }
}
