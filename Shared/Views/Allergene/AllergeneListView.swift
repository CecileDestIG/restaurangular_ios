//
//  AllergeneListView.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct AllergeneListView: View {
    
    @StateObject var listeAllergene : AllergeneListVM = AllergeneListVM()
    
    var body: some View {
        NavigationView{
            // Liste allergenes
            List {
                ForEach(listeAllergene.allergeneList, id:\.id_allergene){item in
                    NavigationLink(destination: AllergeneDetailView(avm: AllergeneVM(allergene: item), alvm: self.listeAllergene)){
                        VStack(alignment: .leading){
                            Text(item.nom_allergene)
                        
                        }
                    }
                }
            }
            .navigationTitle("Allergènes")
            .task{
                //ALLERGENE
                if let list = await AllergeneDAO.allergeneGetAll(){
                    self.listeAllergene.allergeneList = list
                    print("Content list : ",list)
                }
            }
        }
    }
}

struct AllergeneListView_Previews: PreviewProvider {
    static var previews: some View {
        AllergeneListView()
    }
}
