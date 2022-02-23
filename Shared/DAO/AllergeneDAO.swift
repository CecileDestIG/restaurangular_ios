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
            print("bad request")
        }
        return nil
    }
    
    static func allergeneDTOtoAllergene(data : [AllergeneDTO]?) -> [Allergene] {
        var allergeneListe = [Allergene]()
        var allergenedto : [AllergeneDTO]
        if (data != nil){
            allergenedto = data!
        
            for adata in allergenedto {
                let allergene = Allergene(adata.id_allergene, adata.allergene)
                allergeneListe.append(allergene)
            }
        }
        return allergeneListe
    }
}
