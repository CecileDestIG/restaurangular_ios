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
}

struct RecetteInclusDTO : Codable, Hashable {
    var id_recincl : Int
    var place_rec : Int
}
