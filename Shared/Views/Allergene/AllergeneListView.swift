//
//  AllergeneListView.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct AllergeneListView: View {
    
    @StateObject var listeAllergene : AllergeneListVM = AllergeneListVM()
    
    @State var allergenecreate : AllergeneDTO = AllergeneDTO(allergene: "")
    var intentAl : IntentAllergene
    
    init(alvm:AllergeneListVM){
        self.intentAl = IntentAllergene()
        self.intentAl.addObserver(alvm: alvm)
    }
    
    var body: some View {
        NavigationView{
            // Liste allergenes
            VStack{
            List {
                ForEach(listeAllergene.allergeneList, id:\.id_allergene){item in
                    NavigationLink(destination: AllergeneDetailView(avm: AllergeneVM(allergene: item), alvm: self.listeAllergene)){
                        VStack(alignment: .leading){
                            Text(item.nom_allergene)
                        
                        }
                    }
                }
            }
                NavigationLink(destination: AllergeneCreationView(alvm: self.listeAllergene)){
                    Text("Ajouter Allergene").padding()
                }
        }.navigationTitle("Allergènes")
            .task{
                // ALLERGENES
                if let request = await intentAl.intentToLoad(){
                    self.listeAllergene.allergeneList = request
                }

            }
        }
    }
}

struct AllergeneListView_Previews: PreviewProvider {
    static var previews: some View {
        AllergeneListView(alvm: AllergeneListVM())
    }
}
