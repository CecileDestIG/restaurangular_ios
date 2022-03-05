//
//  Accueil.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct Accueil: View {
    
    var body: some View {
        VStack{
            Text("Bienvenue sur restaurangular !")
        }
        .padding(10)
        .foregroundColor(Color.white)
        .background(Color.blue)
        .cornerRadius(10)
    }
}

struct Accueil_Previews: PreviewProvider {
    static var previews: some View {
        Accueil()
    }
}
