//
//  IntentRecette.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 22/02/2022.
//

import Foundation
import Combine

enum IntentStateRecette : CustomStringConvertible, Equatable {
    static func == (lhs: IntentStateRecette, rhs: IntentStateRecette) -> Bool {
        return false
    }
    
    case ready
    case id_createurChanging(Int)
    case nom_recetteChanging(String)
    case nb_couvertChanging(Int)
    case id_categorieChanging(Int)
    case prix_venteChanging(Double)
    case etapesChanging([EtapeInclus])
    case recinclusChanging([RecetteInclus])
    case ingredientsChanging([IngredientInclus])
    case imageChanging(String)

    var description: String {
        switch self{
            case .ready : return "state : .ready"
            case .id_createurChanging(let i) : return "state : .id_createur(\(i))"
            case .nom_recetteChanging(let i) : return "state : .nom_recette(\(i))"
            case .nb_couvertChanging(let i) : return "state : .nb_couvert(\(i))"
            case .id_categorieChanging(let i) : return "state : .id_categorie(\(i))"
            case .prix_venteChanging(let i) : return "state : .prix_vente(\(i))"
            case .etapesChanging(let i) : return "state : .etapes(\(i))"
            case .recinclusChanging(let i) : return "state : .recinclus(\(i))"
            case .ingredientsChanging(let i) : return "state : .ingredients(\(i))"
            case .imageChanging(let i) : return "state : .image(\(i))"
        }
    }
}
    
struct IntentRecette {
    private var stateRecette = PassthroughSubject<IntentStateRecette,Never>()
    
    func addObserver(rvm : RecetteVM){
        self.stateRecette.subscribe(rvm)
    }
    
    func addObserver(rlvm : RecetteListVM){
        self.stateRecette.subscribe(rlvm)
    }
    
    func intentToChange(id_createur:Int){
        self.stateRecette.send(.id_createurChanging(id_createur))
    }
    
    func intentToChange(nom_recette:String){
        self.stateRecette.send(.nom_recetteChanging(nom_recette))
    }
    
    func intentToChange(nb_couvert:Int){
        self.stateRecette.send(.nb_couvertChanging(nb_couvert))
    }
    
    func intentToChange(id_categorie:Int){
        self.stateRecette.send(.id_categorieChanging(id_categorie))
    }
    
    func intentToChange(prix_vente:Double){
        self.stateRecette.send(.prix_venteChanging(prix_vente))
    }
    
    func intentToChange(etapes:[EtapeInclus]){
        self.stateRecette.send(.etapesChanging(etapes))
    }
    
    func intentToChange(recinclus:[RecetteInclus]){
        self.stateRecette.send(.recinclusChanging(recinclus))
    }
    
    func intentToChange(ingredients:[IngredientInclus]){
        self.stateRecette.send(.ingredientsChanging(ingredients))
    }
    
    func intentToChange(image:String){
        self.stateRecette.send(.imageChanging(image))
    }
}

