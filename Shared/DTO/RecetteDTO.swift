//
//  RecetteDTO.swift
//  Restaurangular
//
//  Created by m1 on 22/02/2022.
//

import Foundation

struct RecetteDTO : Codable, Hashable {
    var r : [RecettesDTO]
    var etapes : [EtapeInclusDTO]?
    var recinclus : [RecetteInclusDTO]?
    var ingredients : [IngredientInclusDTO]
}

struct RecettesDTO : Codable, Hashable {
    var id_recette : Int?
    var id_createur : Int
    var nom_recette : String
    var nb_couvert : Int
    var id_categorie : Int
    var prix_vente : Double
    var nom_categorie : String
    var image : String?
}

struct RecetteInclusDTO : Codable, Hashable {
    var id_recincl : Int
    var place_rec : Int
}

struct RecetteInclusCreateDTO : Codable, Hashable {
    var id_recincl : Int
    var place_rec : Int
    var temps_recette : Double
    var cout_production : Double
}

struct RecetteCreateDTO : Codable, Hashable {
    var id_createur : Int
    var nom_recette : String
    var nb_couvert : Int
    var id_categorie : Int
    var prix_vente : Double
    var temps_recette : Double
    var cout_production : Double
    var nom_createur : String
    var ingredients : [IngredientCreateRecetteDTO]
    var recinclus : [RecetteInclusCreateDTO]
    var etapes : [EtapeCreateRecetteDTO]
    var image : String?
}

struct RecetteCreateSansDTO : Codable, Hashable {
    var id_createur : Int
    var nom_recette : String
    var nb_couvert : Int
    var id_categorie : Int
    var prix_vente : Double
    var temps_recette : Double
    var cout_production : Double
    var nom_createur : String
    var ingredients : [IngredientCreateRecetteDTO]
    var recinclus : String
    var etapes : [EtapeCreateRecetteDTO]
    var image : String?
}
