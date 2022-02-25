//
//  Allergene.swift
//  Restaurangular (iOS)
//
//  Created by Ingrid on 19/02/2022.
//

import Foundation

protocol AllergeneObserver{
    func change(nom_allergene:String)
}

class Allergene {
    
    var allergeneObserver : AllergeneObserver?
    
    var id_allergene : Int
    var nom_allergene : String {
        didSet{
            self.allergeneObserver?.change(nom_allergene:self.nom_allergene)
        }
    }
    
    init (_ id_allergene:Int = 0,_ nom_allergene:String = ""){
        self.id_allergene=id_allergene
        self.nom_allergene=nom_allergene
    }
}
