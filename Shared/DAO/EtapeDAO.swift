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
              let etapeInclus = EtapeInclus(id, tdata.place_et,tdata.titre_etape,tdata.id_recette,tdata.temps_etape,tdata.description_etape)
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
    
    
    static func createEtape(etape : EtapeVM) async{
        guard let url = URL(string: "https://restaurangularappli.herokuapp.com/etape") else {
            print("pb url")
            return
        }
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let encoded = await JSONHelper.encode(data: EtapeDTO(titre_etape: etape.titre_etape, temps_etape: etape.temps_etape, description_etape: etape.description_etape)) else {
                print("pb encodage")
                return
            }
            let (data, response) = try await URLSession.shared.upload(for:request,from:encoded)
            _ = String(data: data, encoding: .utf8)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode==201 {
                print("requete 201")
            }
            else{
                print("error status")
            }
        }
        catch{
            print("bad request")
        }
    }
    
    static func modifierEtape(etape:EtapeVM) async{
        guard let url = URL(string: "https://restaurangularappli.herokuapp.com/etape/\(etape.getId())") else {
            print("pb url")
            return
        }
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let encoded = await JSONHelper.encode(data: EtapeDTO(titre_etape: etape.titre_etape, temps_etape: etape.temps_etape, description_etape: etape.description_etape)) else {
                print("pb encodage")
                return
            }
            let (data, response) = try await URLSession.shared.upload(for:request,from:encoded)
            let sdata = String(data: data, encoding: .utf8)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode==201 {
                print("requete 201")
            }
            else{
                print("error status")
            }
        }
        catch{
            print("bad request")
        }
    }
}
