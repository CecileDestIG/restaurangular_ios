//
//  Ingredient.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 19/02/2022.
//

import Foundation

protocol IngredientObserver{
    func change(nom_ingredient:String)
    func change(unite:String)
    func change(cout_unitaire:Double)
    func change(stock:Double)
    func change(id_cat_ingr:Int)
    func change(id_allergene:Int)
    func change(image:String?)
}

class Ingredient {
    
    var ingredientObserver : IngredientObserver?
    
    var id_ingredient : Int
    var nom_ingredient : String {
        didSet{
            self.ingredientObserver?.change(nom_ingredient : self.nom_ingredient)
        }
    }
    
    var unite : String {
        didSet{
            self.ingredientObserver?.change(unite : self.unite)
        }
    }
    
    var cout_unitaire : Double {
        didSet{
            self.ingredientObserver?.change(cout_unitaire : self.cout_unitaire)
        }
    }
    
    var stock : Double {
        didSet{
            self.ingredientObserver?.change(stock : self.stock)
        }
    }
    
    var id_cat_ingr : Int {
        didSet{
            self.ingredientObserver?.change(id_cat_ingr : self.id_cat_ingr)
        }
    }
    
    var id_allergene : Int {
        didSet{
            self.ingredientObserver?.change(id_allergene : self.id_allergene)
        }
    }

    var allergene : String
    
    var nom_cat_ingr : String
    
    var image : String?
    
    init (_ id_ingredient:Int = 0,_ nom_ingredient:String = "",_ unite:String = "",_ cout_unitaire:Double = 0.0,_ stock:Double = 0,_ id_cat_ingr : Int = 0,_ id_allergene : Int = 0,_ allergene : String = "",_ nom_cat_ingr : String = "",_ image : String? = nil){
        self.id_ingredient=id_ingredient
        self.nom_ingredient=nom_ingredient
        self.unite=unite
        self.cout_unitaire=cout_unitaire
        self.stock=stock
        self.id_cat_ingr=id_cat_ingr
        self.id_allergene=id_allergene
        self.allergene=allergene
        self.nom_cat_ingr=nom_cat_ingr
        self.image=image
    }
}

class IngredientInclus {
    var id_ingredient : Int
    var nom_ingredient : String
    var unite : String
    var cout_unitaire : Double
    var stock : Double
    var id_allergene : Int?
    var allergene : String?
    var id_cat_ingr : Int
    var nom_cat_ingr : String
    var id_recette : Int
    var quantite_necessaire : Double
    
    init(_ id_ingredient : Int = 0,_ quantite_necessaire : Double = 0,_ nom_ingredient : String = "",_ unite : String = "",_ cout_unitaire : Double = 0,_ stock : Double = 0,_ id_allergene : Int = 0,_ allergene : String = "",_ id_cat_ingr : Int = 0,_ nom_cat_ingr : String = "",_ id_recette : Int = 0){
        self.id_ingredient = id_ingredient
        self.nom_ingredient = nom_ingredient
        self.unite = unite
        self.cout_unitaire = cout_unitaire
        self.stock = stock
        self.id_allergene = id_allergene
        self.allergene = allergene
        self.id_cat_ingr = id_cat_ingr
        self.nom_cat_ingr = nom_cat_ingr
        self.id_recette = id_recette
        self.quantite_necessaire = quantite_necessaire
    }
}

class IngredientCreateInclus {
    var id_ingredient : Int
    var quantite_necessaire : Double
    var nom_ingredient : String
    var unite : String
    
    init(id_ingredient : Int, quantite : Double, nom : String, unite : String){
        self.id_ingredient=id_ingredient
        self.quantite_necessaire=quantite
        self.nom_ingredient=nom
        self.unite=unite
    }
}
