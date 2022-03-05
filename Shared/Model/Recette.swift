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
    "nom_categorie":"Plat",
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
    func change(etapes:[EtapeInclus]?)
    func change(recinclus:[RecetteInclus]?)
    func change(ingredients:[IngredientInclus]?)
    func change(image:String?)

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
    
    var image : String? {
        didSet{
            self.recetteObserver?.change(image : self.image)
        }
    }
    
    init(_ id_recette:Int = 0,_ id_createur : Int = 0,_ nom_recette : String = "",_ nb_couvert : Int = 0,_ id_categorie : Int = 0,_ nom_categorie : String = "",_ prix_vente : Double = 0,_ etapes : [EtapeInclus]? = nil,_ recinclus : [RecetteInclus]? = nil,_ ingredients : [IngredientInclus]? = nil,_ image : String? = nil){
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
    }
}

class RecetteInclus {
    var id_recincl : Int
    var place_rec : Int
    
    init(_ id_recincl : Int = 0,_ place_rec : Int = 0){
        self.id_recincl = id_recincl
        self.place_rec = place_rec
    }
}



class RecetteInclAffiche{
    
    var titre_recette : String
    var id : Int
    @Published var place_rec : Int
    
    init(titre_recette:String,id:Int,place_rec:Int){
        self.titre_recette=titre_recette
        self.id=id
        self.place_rec=place_rec
    }
    
}
