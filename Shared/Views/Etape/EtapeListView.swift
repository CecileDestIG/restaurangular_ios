//
//  EtapeListView.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct EtapeListView: View {
    
    @StateObject var etapeList : EtapeListVM = EtapeListVM()
    
    var body: some View {
        NavigationView{
            // Liste etape
            VStack{
            List {
                ForEach(etapeList.etape_list, id:\.id_etape){item in
                    NavigationLink(destination: EtapeDetailView(evm: EtapeVM(e: item), elvm: self.etapeList)){
                        VStack(alignment: .leading){
                            Text(item.titre_etape)
                        }
                    }
                }
            }
            NavigationLink(destination: EtapeCreateView(elvm: self.etapeList)){
                Text("Ajouter Etape").padding()
            }
            }
            .navigationTitle("Etapes")
            .task {
                // ETAPES
                if let list = await EtapeDAO.getAllEtape(){
                    self.etapeList.etape_list = list
                }
            }
        }
    }
}


struct EtapeListView_Previews: PreviewProvider {
    static var previews: some View {
        EtapeListView()
    }
}
