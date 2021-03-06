//
//  CatIngr.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 19/02/2022.
//

import Foundation

protocol CatIngrObserver{
    func change(nom_cat_ingr:String)
}

class CatIngr {
    
    var catIngrObserver : CatIngrObserver?
    
    var id_cat_ingr : Int
    var nom_cat_ingr : String {
        didSet{
            self.catIngrObserver?.change(nom_cat_ingr : self.nom_cat_ingr)
        }
    }
    
    init (_ id_cat_ingr:Int = 0, _ nom_cat_ingr:String = ""){
        self.id_cat_ingr=id_cat_ingr
        self.nom_cat_ingr=nom_cat_ingr
    }
}
