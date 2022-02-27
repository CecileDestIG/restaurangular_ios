//
//  AllergeneCreationView.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 25/02/2022.
//

import Foundation
import SwiftUI

struct AllergeneCreationView : View {
    
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intentAl : IntentAllergene
    @State var allergenecreate : AllergeneDTO = AllergeneDTO(allergene: "")
    
    init( alvm:AllergeneListVM ){
        self.intentAl=IntentAllergene()
        self.intentAl.addObserver(alvm: alvm)
    }
    
    var body : some View {
        VStack{
            Form{
                HStack{
                    TextField("nom allergene : ", text : $allergenecreate.allergene)
                }
                Button("nouvel allergene"){
                    Task{
                        await AllergeneDAO.createAllergene(nom_allergene: allergenecreate.allergene)
                    }
                }
            }
        }.padding()
    }
}
