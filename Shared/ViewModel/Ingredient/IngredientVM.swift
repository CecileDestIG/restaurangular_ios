//
//  IngredientVM.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 19/02/2022.
//

import Foundation
import Combine

enum IngredientVMError : Error, CustomStringConvertible, Equatable {
    case noError
    case nom_ingredientError(String)
    case uniteError(String)
    case cout_unitaireError(Double)
    case stockError(Double)
    case id_cat_ingrError(Int)
    case id_allergeneError(Int)
    
    var description: String {
        switch self {
        case .noError : return "No error"
        case .nom_ingredientError(let i) :  return "Erreur dans le nom d'ingredient :  \(i)"
        case .uniteError(let i) :  return "Erreur dans unite :  \(i)"
        case .cout_unitaireError(let i) :  return "Erreur dans cout unitaire :  \(i)"
        case .stockError(let i) :  return "Erreur dans stock :  \(i)"
        case .id_cat_ingrError(let i) :  return "Erreur dans id cat ingr :  \(i)"
        case .id_allergeneError(let i) :  return "Erreur dans id allergene :  \(i)"
        }
    }
}
    
class IngredientVM : ObservableObject, IngredientObserver, Subscriber, Hashable{

    static func == (lhs: IngredientVM, rhs: IngredientVM) -> Bool {
        lhs.getId()==rhs.getId()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ingredient.id_ingredient)
    }
    
    typealias Input = IntentStateIngredient
    
    typealias Failure = Never
    
        
    private var ingredient : Ingredient
    @Published var nom_ingredient : String
    @Published var unite : String
    @Published var cout_unitaire : Double
    @Published var stock : Double
    @Published var id_cat_ingr : Int
    @Published var id_allergene : Int
    @Published var nom_cat_ingr : String
    @Published var allergene : String
    
    func getId()->Int{
        return ingredient.id_ingredient
    }
    
    func change(nom_ingredient: String) {
        print("vm observer: nom_ingredient changé => self.nom_ingredient = '\(nom_ingredient)'")
        self.nom_ingredient=nom_ingredient
    }
    
    func change(unite: String) {
        print("vm observer: unite changé => self.unite = '\(unite)'")
        self.unite=unite
    }
    
    func change(cout_unitaire: Double) {
        print("vm observer: cout_unitaire changé => self.cout_unitaire = '\(cout_unitaire)'")
        self.cout_unitaire=cout_unitaire
    }
    
    func change(stock: Double) {
        print("vm observer: stock changé => self.stock = '\(stock)'")
        self.stock=stock
    }
    
    func change(id_cat_ingr: Int) {
        print("vm observer: id_cat_ingr changé => self.id_cat_ingr = '\(id_cat_ingr)'")
        self.id_cat_ingr=id_cat_ingr
    }
    
    func change(id_allergene: Int) {
        print("vm observer: id_allergene changé => self.id_allergene = '\(id_allergene)'")
        self.id_allergene=id_allergene
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(_ input: IntentStateIngredient) -> Subscribers.Demand {
        print("vm -> intent \(input)")
        switch input {
        case .ready :
            break
        case .ingredientCreate(_):
            print("ingredient create")
        case .ingredientChanging(let i):
            print("ingredient change")
            let niClean = i.nom_ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
            print("vm : change model nom ingr to '\(niClean)'")
            self.ingredient.nom_ingredient=niClean
            print("vm : change model nom cat ingr to '\(self.ingredient.nom_ingredient)'")
            let iClean = i.unite.trimmingCharacters(in: .whitespacesAndNewlines)
            print("vm : change model unite to '\(iClean)'")
            self.ingredient.unite=iClean
            print("vm : change model unite to '\(self.ingredient.unite)'")
            self.ingredient.cout_unitaire=i.cout_unitaire
            print("vm : change model cout unite to '\(self.ingredient.cout_unitaire)'")
            self.ingredient.stock=i.stock
            print("vm : change model stock to '\(self.ingredient.stock)'")
            self.ingredient.id_cat_ingr=i.id_cat_ingr
            print("vm : change model id_cat_ingr to '\(self.ingredient.id_cat_ingr)'")
            self.ingredient.id_allergene=i.id_allergene
            print("vm : change model id_allergene to '\(self.ingredient.id_allergene)'")
            
            
        }
        return .none
    }
    
    init(i : Ingredient){
        self.ingredient=i
        self.nom_ingredient=i.nom_ingredient
        self.unite=i.unite
        self.stock=i.stock
        self.cout_unitaire=i.cout_unitaire
        self.id_cat_ingr=i.id_cat_ingr
        self.id_allergene=i.id_allergene
        self.allergene = i.allergene
        self.nom_cat_ingr = i.nom_cat_ingr
    }
}
