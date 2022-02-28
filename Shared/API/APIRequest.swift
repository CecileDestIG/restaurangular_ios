//
//  RequestAPI.swift
//  Restaurangular
//
//  Created by m1 on 22/02/2022.
//

import Foundation

class APIRequest {
    
    private static var urlBack = "https://restaurangularappli.herokuapp.com/"
    
    
    static public func getAll<T : Decodable>(route : String, dto : T.Type) async -> [T]? {
        // Setup the request
        guard let url = URL(string : urlBack+route) else {
            print("Bad GoRest URL.")
            return nil
        }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let gorest : [T] = await JSONHelper.decode(data: data) else {
                print("API Request getAll error : GoRest pb")
                return nil
            }
           return gorest
        }
        catch{
            print("bad request")
            return nil
        }
    }
    
    static public func get<T : Decodable>(route : String, dto : T.Type) async -> T? {
        guard let url = URL(string : urlBack+route) else {
            print("Bad GoRest URL.")
            return nil
        }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let gorest : T = await JSONHelper.decode(data: data) else {
                print("API Request get error : GoRest pb")
                return nil
            }
            return gorest
        }
        catch{
            print("bad request")
            return nil
        }
    }
}
