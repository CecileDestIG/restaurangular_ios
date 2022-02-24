//
//  RecetteDTO.swift
//  Restaurangular
//
//  Created by m1 on 22/02/2022.
//

import Foundation

/*
struct RecetteDTO : Codable, Hashable {
    var id_recette : Int?
    var id_createur : Int
    var nom_recette : String
    var nb_couvert : Int
    var id_categorie : Int
    var prix_vente : Double
    var etapes : [Etape]?
    var recinclus : [Recette]?
    var ingredients : [Ingredient]
}
*/
struct RecettesDTO : Codable, Hashable {
    var id_recette : Int?
    var id_createur : Int
    var nom_recette : String
    var nb_couvert : Int
    var id_categorie : Int
    var prix_vente : Double
}
