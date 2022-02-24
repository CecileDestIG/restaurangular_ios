//
//  RecetteVM.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 22/02/2022.
//

import Foundation
import Combine
import CloudKit

enum RecetteVMError : Error, CustomStringConvertible, Equatable {
    static func == (lhs: RecetteVMError, rhs: RecetteVMError) -> Bool {
        return false
    }
    
    case noError
    case id_createurError(Int)
    case nom_recetteError(String)
    case nb_couvertError(Int)
    case id_categorieError(Int)
    case prix_venteError(Double)
    case etapesError([Etape])
    case recinclusError([Recette])
    case ingredientsError([Ingredient])

    var description: String {
        switch self {
        case .noError : return "No error"
        case .id_createurError(let i) :  return "Erreur dans id createur :  \(i)"
        case .nom_recetteError(let i) :  return "Erreur dans nom recette :  \(i)"
        case .nb_couvertError(let i) :  return "Erreur dans nb couvert :  \(i)"
        case .prix_venteError(let i) :  return "Erreur dans ptix vente :  \(i)"
        case .id_categorieError(let i) :  return "Erreur dans id categorie :  \(i)"
        case .etapesError(let i) :  return "Erreur dans etapes :  \(i)"
        case .recinclusError(let i) :  return "Erreur dans les recettes incluses :  \(i)"
        case .ingredientsError(let i) :  return "Erreur dans ingredients :  \(i)"
        }
    }
}
    
class RecetteVM : ObservableObject, RecetteObserver, Subscriber{

    
    typealias Input = IntentStateRecette
    
    typealias Failure = Never
    
        
    private var recette : Recette
    @Published var id_createur : Int
    @Published var nom_recette : String
    @Published var nb_couvert : Int
    @Published var id_categorie : Int
    @Published var prix_vente : Double
    @Published var etapes : [Etape]?
    @Published var recinclus : [Recette]?
    @Published var ingredients : [Ingredient]?
    
    func change(id_createur: Int) {
        print("vm observer: id_createur changé => self.id_createur = '\(id_createur)'")
        self.id_createur=id_createur
    }
    
    func change(nom_recette: String) {
        print("vm observer: nom_recette changé => self.nom_recette = '\(nom_recette)'")
        self.nom_recette=nom_recette
    }
    
    func change(nb_couvert: Int) {
        print("vm observer: nb_couvert changé => self.nb_couvert = '\(nb_couvert)'")
        self.nb_couvert=nb_couvert
    }
    
    func change(id_categorie: Int) {
        print("vm observer: id_categorie changé => self.id_categorie = '\(id_categorie)'")
        self.id_categorie=id_categorie
    }
    
    func change(prix_vente: Double) {
        print("vm observer: prix_vente changé => self.prix_vente = '\(prix_vente)'")
        self.prix_vente=prix_vente
    }
    
    func change(etapes: [Etape]?) {
        print("vm observer: etapes changé => self.etapes")
        self.etapes=etapes
    }
    
    func change(recinclus: [Recette]?) {
        print("vm observer: recinclus changé => self.recinclus")
        self.recinclus=recinclus
    }
    
    func change(ingredients: [Ingredient]?) {
        print("vm observer: ingredients changé => self.ingredients")
        self.ingredients=ingredients
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(_ input: IntentStateRecette) -> Subscribers.Demand {
        print("vm -> intent \(input)")
        switch input {
        case .ready :
            break
        case .id_createurChanging(let r):
            self.recette.id_createur=r
            print("vm : change model id createur to '\(self.recette.id_createur)'")
        case .nom_recetteChanging(let r):
            let rClean = r.trimmingCharacters(in: .whitespacesAndNewlines)
            print("vm : change model nom_recette to '\(rClean)'")
            self.recette.nom_recette=rClean
            print("vm : change model nom recette to '\(self.recette.nom_recette)'")
        case .nb_couvertChanging(let r):
            self.recette.nb_couvert=r
            print("vm : change model nb couvert to '\(self.recette.nb_couvert)'")
        case .id_categorieChanging(let r):
            self.recette.id_categorie=r
            print("vm : change model id categorie to '\(self.recette.id_categorie)'")
        case .prix_venteChanging(let r):
            self.recette.prix_vente=r
            print("vm : change model prix vente to '\(self.recette.prix_vente)'")
        case .etapesChanging(let r):
            self.recette.etapes=r
            print("vm : change model etapes")
        case .recinclusChanging(let r):
            self.recette.recinclus=r
            print("vm : change model recettes")
        case .ingredientsChanging(let r):
            self.recette.ingredients=r
            print("vm : change model ingredients")
        }
        return .none
    }
    
    init(r : Recette){
        self.recette=r
        self.id_createur=r.id_createur
        self.nom_recette=r.nom_recette
        self.nb_couvert=r.nb_couvert
        self.id_categorie=r.id_categorie
        self.prix_vente=r.prix_vente
        self.etapes=r.etapes
        self.recinclus = r.recinclus
        self.ingredients = r.ingredients
    }
}

