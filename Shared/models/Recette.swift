//
//  Recette.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 22/02/2022.
//

import Foundation
/*{
    "id_createur" :1,
    "nom_recette" : "Lasagne",
    "nb_couvert" : 8,
    "id_categorie":2,
    "prix_vente":8.99,
    "etapes":[
        {
            "id_etape":1,
            "place_et":1
        },
        {
            "id_etape":1,
            "place_et":2
        }
    ],
    "recinclus":[
        {
            "id_recincl":30,
            "place_rec":5
        }
    ],
    "ingredients":[
        {
            "id_ingredient":2,
            "quantite_necessaire":12
        },
        {
            "id_ingredient":3,
            "quantite_necessaire":2
        },
        {
            "id_ingredient":5,
            "quantite_necessaire":6
        }
    ]
}
*/

protocol RecetteObserver{
    func change(id_createur:Int)
    func change(nom_recette:String)
    func change(nb_couvert:Int)
    func change(id_categorie:Int)
    func change(prix_vente:Double)
    func change(etapes:[Etape])
    func change(recinclus:[Recette])
    func change(ingredients:[Ingredient])

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
    
    var prix_vente : Double {
        didSet{
            self.recetteObserver?.change(prix_vente : self.prix_vente)
        }
    }
    
    var etapes : [Etape] {
        didSet{
            self.recetteObserver?.change(etapes : self.etapes)
        }
    }

    var recinclus : [Recette] {
        didSet{
            self.recetteObserver?.change(recinclus : self.recinclus)
        }
    }
    
    var ingredients : [Ingredient] {
        didSet{
            self.recetteObserver?.change(ingredients : self.ingredients)
        }
    }
    
    init(id_recette:Int, id_createur : Int, nom_recette : String, nb_couvert : Int, id_categorie : Int, prix_vente : Double, etapes : [Etape], recinclus : [Recette], ingredients : [Ingredient] ){
        self.id_recette=id_recette
        self.id_createur=id_createur
        self.nom_recette=nom_recette
        self.nb_couvert=nb_couvert
        self.id_categorie=id_categorie
        self.prix_vente=prix_vente
        self.etapes=etapes
        self.recinclus=recinclus
        self.ingredients=ingredients
    }
}
