//
//  Recette.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 22/02/2022.
//

import Foundation

protocol RecetteObserver{
    func change(id_createur:Int)
    func change(nom_recette:String)
    func change(nb_couvert:Int)
    func change(id_categorie:Int)
    func change(prix_vente:Double)
    func change(etapes:[EtapeInclus]?)
    func change(recinclus:[RecetteInclus]?)
    func change(ingredients:[IngredientInclus]?)
    func change(image:String)

}

class Recette {
    
    var recetteObserver : RecetteObserver?
    
    var id_recette : Int
    
    var id_createur : Int {
        didSet{
            self.recetteObserver?.change(id_createur : self.id_createur)
        }
    }
    
    var nom_recette : String {
        didSet{
            self.recetteObserver?.change(nom_recette : self.nom_recette)
        }
    }
    
    var nb_couvert : Int {
        didSet{
            self.recetteObserver?.change(nb_couvert : self.nb_couvert)
        }
    }
    
    var id_categorie : Int {
        didSet{
            self.recetteObserver?.change(id_categorie : self.id_categorie)
        }
    }
    
    var nom_categorie : String
    
    var prix_vente : Double {
        didSet{
            self.recetteObserver?.change(prix_vente : self.prix_vente)
        }
    }
    
    var etapes : [EtapeInclus]? {
        didSet{
            self.recetteObserver?.change(etapes : self.etapes)
        }
    }

    var recinclus : [RecetteInclus]? {
        didSet{
            self.recetteObserver?.change(recinclus : self.recinclus)
        }
    }
    
    var ingredients : [IngredientInclus]? {
        didSet{
            self.recetteObserver?.change(ingredients : self.ingredients)
        }
    }
    
    var image : String {
        didSet{
            self.recetteObserver?.change(image : self.image)
        }
    }
    
    var cout_production : Double
    
    var temps_recette : Double
    
    init(_ id_recette:Int = 0,_ id_createur : Int = 0,_ nom_recette : String = "",_ nb_couvert : Int = 0,_ id_categorie : Int = 0,_ nom_categorie : String = "",_ prix_vente : Double = 0,_ etapes : [EtapeInclus]? = nil,_ recinclus : [RecetteInclus]? = nil,_ ingredients : [IngredientInclus]? = nil,_ image : String = "",_ cout_production : Double = 0,_ temps_recette : Double = 0){
        self.id_recette=id_recette
        self.id_createur=id_createur
        self.nom_recette=nom_recette
        self.nb_couvert=nb_couvert
        self.id_categorie=id_categorie
        self.prix_vente=prix_vente
        self.etapes=etapes
        self.recinclus=recinclus
        self.ingredients=ingredients
        self.nom_categorie = nom_categorie
        self.image = image
        self.cout_production = cout_production
        self.temps_recette = temps_recette
    }
}

class RecetteInclus {
    var id_recincl : Int
    var place_rec : Int
    var temps_recetteincl : Double
    var cout_productionincl : Double
    
    init(_ id_recincl : Int = 0,_ place_rec : Int = 0,_ temps_recetteincl : Double = 0,_ cout_productionincl : Double = 0){
        self.id_recincl = id_recincl
        self.place_rec = place_rec
        self.temps_recetteincl = temps_recetteincl
        self.cout_productionincl = cout_productionincl
    }
}



class RecetteInclAffiche{
    
    var titre_recette : String
    var id : Int
    @Published var place_rec : Int
    var temps : Double
    var cout_production: Double
    
    init(titre_recette:String,id:Int,place_rec:Int, temps: Double, cout:Double){
        self.titre_recette=titre_recette
        self.id=id
        self.place_rec=place_rec
        self.temps = temps
        self.cout_production=cout
    }
    
}
