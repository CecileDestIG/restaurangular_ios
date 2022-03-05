//  AllergeneDAO.swift
//  Restaurangular (iOS)
//
//  Created by Cecile on 22/02/2022.
//

import Foundation

struct AllergeneDAO {
    
    static func allergeneGetAll() async -> [Allergene]?{
        print("debut task")
        guard let url = URL(string: "https://restaurangularappli.herokuapp.com/allergene") else {
            print("bad request")
            return nil
        }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let gorest : [AllergeneDTO] = await JSONHelper.decode(data: data) else{
                print("pb decodage")
                return nil
            }
            return AllergeneDAO.allergeneDTOtoAllergene(data: gorest)
        }
        catch{
            print("bad request get all allergene")
        }
        return nil
    }
    
    static func allergeneDTOtoAllergene(data : [AllergeneDTO]?) -> [Allergene] {
        var allergeneListe = [Allergene]()
        var allergenedto : [AllergeneDTO]
        if (data != nil){
            allergenedto = data!
        
            for adata in allergenedto {
                if (adata.id_allergene != nil){
                    let allergene = Allergene(adata.id_allergene!, adata.allergene)
                    allergeneListe.append(allergene)
                }
            }
        }
        return allergeneListe
    }
    
    static func createAllergene(nom_allergene : String) async{
        guard let url = URL(string: "https://restaurangularappli.herokuapp.com/allergene") else {
            print("pb url")
            return
        }
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let encoded = await JSONHelper.encode(data: AllergeneDTO(allergene: nom_allergene)) else {
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
            print("bad request create allergene")
        }
    }

    static func modifierAllergene( id_allergene:Int, nom_allergene : String) async{
        guard let url = URL(string: "https://restaurangularappli.herokuapp.com/allergene/\(id_allergene)") else {
            print("pb url")
            return
        }
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let encoded = await JSONHelper.encode(data: AllergeneDTO(allergene: nom_allergene)) else {
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
            print("bad request modifier allergene")
        }
    }
}

