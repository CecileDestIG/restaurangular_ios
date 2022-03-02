//
//  Accueil.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct Accueil: View {
    
    var body: some View {
        NavigationView{
            ZStack{
                Text("Bienvenue sur restaurangular !")
            }
        }
    }
}

struct Accueil_Previews: PreviewProvider {
    static var previews: some View {
        Accueil()
    }
}
