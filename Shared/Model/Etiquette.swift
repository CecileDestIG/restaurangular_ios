//
//  Etiquette.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 05/03/2022.
//

import Foundation

class Etiquette : ObservableObject {
    
    @Published var recetteList : RecetteListVM{
        didSet{
            objectWillChange.send()
        }
    }
    @Published var id_recette : Int{
        didSet{
            objectWillChange.send()
        }
    }
    
    var recette : RecetteVM{
        var recette : RecetteVM = RecetteVM(r: Recette())
        for r in self.recetteList.recette_list {
            if(r.id_recette == self.id_recette){
                print("recette trouvée: ",r)
                recette = RecetteVM(r:r)
            }
        }
        return recette
    }
    
    init(_ id_recette : Int = 0,_ recetteList : RecetteListVM = RecetteListVM()){
        self.id_recette = id_recette
        self.recetteList = recetteList
    }
    
}
