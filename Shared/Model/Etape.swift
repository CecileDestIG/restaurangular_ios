//
//  Etape.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 20/02/2022.
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
    
    init (id_etape:Int, titre_etape:String, temps_etape: Double, description_etape: String){
        self.id_etape=id_etape
        self.titre_etape=titre_etape
        self.temps_etape=temps_etape
        self.description_etape=description_etape
    }
}