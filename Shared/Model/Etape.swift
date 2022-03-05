//
//  Etape.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 20/02/2022.
//

import Foundation

protocol EtapeObserver{
    func change(titre_etape:String)
    func change(temps_etape:Double)
    func change(description_etape:String)
}

class Etape {
    
    var etapeObserver : EtapeObserver?
    
    var id_etape : Int
    var titre_etape : String {
        didSet{
            self.etapeObserver?.change(titre_etape:self.titre_etape)
        }
    }
    
    var temps_etape : Double {
        didSet{
            self.etapeObserver?.change(temps_etape:self.temps_etape)
        }
    }
    
    var description_etape : String {
        didSet{
            self.etapeObserver?.change(description_etape:self.description_etape)
        }
    }
    
    init (_ id_etape:Int = 0,_ titre_etape:String = "",_ temps_etape: Double = 0.0,_ description_etape: String = ""){
        self.id_etape=id_etape
        self.titre_etape=titre_etape
        self.temps_etape=temps_etape
        self.description_etape=description_etape
    }
}

class EtapeInclus {
    var id_etape : Int
    var titre_etape : String
    var id_recette : Int
    var place_et : Int
    var temps_etape : Double
    var description_etape : String
    
    init(_ id_etape : Int = 0,_ place_et : Int = 0,_ titre_etape : String = "",_ id_recette : Int = 0,_ temps_etape : Double = 0.0,_ description_etape : String = ""){
        self.id_etape = id_etape
        self.titre_etape = titre_etape
        self.id_recette = id_recette
        self.place_et = place_et
        self.temps_etape = temps_etape
        self.description_etape = description_etape
    }
}

class EtapeInclusCreate : Hashable {
    static func == (lhs: EtapeInclusCreate, rhs: EtapeInclusCreate) -> Bool {
        lhs.id_etape==rhs.id_etape
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id_etape)
    }
    
    var id_etape : Int
    var titre_etape : String
    var description_etape : String
    var temps_etape : Double
    var place_et : Int

    
    init(id_etape : Int = 0,place_et : Int = 0,titre_etape : String = "", temps_etape : Double = 0.0, description_etape : String = ""){
        self.id_etape = id_etape
        self.titre_etape = titre_etape
        self.place_et = place_et
        self.temps_etape = temps_etape
        self.description_etape = description_etape
    }
}
