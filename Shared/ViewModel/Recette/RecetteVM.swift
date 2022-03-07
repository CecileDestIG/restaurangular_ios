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
    case imageError(String)

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
        case .imageError(let i) :  return "Erreur dans image :  \(i)"
        }
    }
}
    
class RecetteVM : ObservableObject, RecetteObserver, Subscriber, Hashable{
    
    static func == (lhs: RecetteVM, rhs: RecetteVM) -> Bool {
        lhs.getId()==rhs.getId()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(recette.id_recette)
    }
    
    typealias Input = IntentStateRecette
    
    typealias Failure = Never
    
    func getId()->Int{
        return recette.id_recette
    }
    
    func tempsRecette() -> Double{
        var t : Double = 0
        if let rec = self.recinclus{
            for r in rec{
                t += r.temps_recetteincl
            }
        }
        if let et = self.etapes{
            for e in et{
                t += e.temps_etape
            }
        }
        return t
    }
    
    func coutMatiere(type:Bool = true,relatif:Double = 5,absolu:Double = 0) -> Double{
        var abs = absolu
        var rel = relatif
        if(type){
            abs = 0
        }
        else{
            rel = 0
        }
        var cm : Double = 0
        if let ing = self.ingredients{
            for i in ing{
                cm += Double(i.cout_unitaire) * Double(i.quantite_necessaire)
            }
            return cm*(1+rel/100)+abs
        }
        else{
            return 0
        }
    }
    
    func coutCharge(coutFluide : Double = 0.5, coutPersonnel : Double = 10) -> Double{
        return (tempsRecette()/60)*(coutFluide+coutPersonnel)
    }

    func coutProduction(type:Bool=true,coutMatiere:Double,coutCharge:Double) -> Double{
        var cp : Double = 0
        var cc = coutCharge
        if(!type){
            cc = 0
        }
        if let rec = self.recinclus{
            for r in rec{
                cp += r.cout_productionincl
            }
        }
        return coutMatiere+cc+cp
    }
        
    private var recette : Recette
    @Published var id_createur : Int
    @Published var nom_recette : String
    @Published var nb_couvert : Int
    @Published var id_categorie : Int
    @Published var nom_categorie : String
    @Published var prix_vente : Double
    @Published var etapes : [EtapeInclus]?
    @Published var recinclus : [RecetteInclus]?
    @Published var ingredients : [IngredientInclus]?
    @Published var image : String
    // gestion des couts
    
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
    
    func change(etapes: [EtapeInclus]?) {
        print("vm observer: etapes changé => self.etapes")
        self.etapes=etapes
    }
    
    func change(recinclus: [RecetteInclus]?) {
        print("vm observer: recinclus changé => self.recinclus")
        self.recinclus=recinclus
    }
    
    func change(ingredients: [IngredientInclus]?) {
        print("vm observer: ingredients changé => self.ingredients")
        self.ingredients=ingredients
    }
    
    func change(image: String) {
        print("vm observer: image changée => self.image")
        self.image=image
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
        case .recetteCreate(let r):
            print("recette create \(r.nom_recette)")
        case .recetteChanging(let r):
            self.recette.id_createur=r.id_createur
            print("vm : change model id createur to '\(self.recette.id_createur)'")
            let rClean = r.nom_recette.trimmingCharacters(in: .whitespacesAndNewlines)
            print("vm : change model nom_recette to '\(rClean)'")
            self.recette.nom_recette=rClean
            print("vm : change model nom recette to '\(self.recette.nom_recette)'")
            self.recette.nb_couvert=r.nb_couvert
            print("vm : change model nb couvert to '\(self.recette.nb_couvert)'")
            self.recette.id_categorie=r.id_categorie
            print("vm : change model id categorie to '\(self.recette.id_categorie)'")
            self.recette.prix_vente=r.prix_vente
            print("vm : change model prix vente to '\(self.recette.prix_vente)'")
            self.recette.etapes=r.etapes
            print("vm : change model etapes")
            self.recette.recinclus=r.recinclus
            print("vm : change model recettes")
            self.recette.ingredients=r.ingredients
            print("vm : change model ingredients")
            self.recette.image=r.image
            print("vm : change model image")
        }
        return .none
    }
    
    init(r : Recette){
        self.recette=r
        self.id_createur=r.id_createur
        self.nom_recette=r.nom_recette
        self.nb_couvert=r.nb_couvert
        self.id_categorie=r.id_categorie
        self.nom_categorie=r.nom_categorie
        self.prix_vente=r.prix_vente
        self.etapes=r.etapes
        self.recinclus = r.recinclus
        self.ingredients = r.ingredients
        self.image = r.image
    }
}

