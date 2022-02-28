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
            Text("Création Allergène").font(.largeTitle).bold()
            Form{
                HStack{
                    TextField("nom allergene : ", text : $allergenecreate.allergene)
                }
                HStack{
                    Spacer()
                    Button("nouvel allergene"){
                        Task{
                            await AllergeneDAO.createAllergene(nom_allergene: allergenecreate.allergene)
                        }
                    }
                    Spacer()

                }
            }
        }
    }
}
