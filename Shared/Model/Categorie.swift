//
//  Categorie.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 02/03/2022.
//

import Foundation

protocol CategorieObserver{
    func change(nom_categorie:String)
}


class Categorie {
    
    var categorieObserver : CategorieObserver?
    
    var id_categorie : Int
    var nom_categorie : String {
        didSet{
            self.categorieObserver?.change(nom_categorie : self.nom_categorie)
        }
    }
    
    init (_ id_categorie:Int = 0, _ nom_categorie:String = ""){
        self.id_categorie=id_categorie
        self.nom_categorie=nom_categorie
    }
}
