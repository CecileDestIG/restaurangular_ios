//
//  EtapeDAO.swift
//  Restaurangular
//
//  Created by m1 on 22/02/2022.
//

import Foundation


class EtapeDAO {
    
    static func getAllEtape() async -> [Etape]?{
        if let list = await APIRequest.getAll(route: "etape", dto: EtapeDTO.self){
            return EtapeDAO.toEtape(data: list)
        }
        return nil
    }
    
    // Conversion
    
    static func toEtapeInclus(data: [EtapeInclusDTO]) -> [EtapeInclus]?{
          var etapeInclus_list = [EtapeInclus]()
          for tdata in data{
              let id : Int = tdata.id_etape
              let etapeInclus = EtapeInclus(id, tdata.place_et)
             etapeInclus_list.append(etapeInclus)
          }
    print("etapeInclus_list : ",etapeInclus_list)
    return etapeInclus_list
    }
    
    static func toEtape(data: [EtapeDTO]) -> [Etape]?{
          var etape_list = [Etape]()
          for tdata in data{
             guard (tdata.id_etape != nil) else{
                return nil
             }
             let id : Int = tdata.id_etape ?? tdata.id_etape!
              let etape = Etape(id, tdata.titre_etape, tdata.temps_etape, tdata.description_etape)
              etape_list.append(etape)
          }
    return etape_list
    }
}
