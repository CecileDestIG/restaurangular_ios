//
//  RequestAPI.swift
//  Restaurangular
//
//  Created by m1 on 22/02/2022.
//

import Foundation

class APIRequest {
    
    private static var urlBack = "https://restaurangularappli.herokuapp.com/"
    
    // GETALL
    
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
    
    //GET
    
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
    
    //CREATE
    
    static func create<T:Encodable>(route : String, dtoElement : T) async{
        guard let url = URL(string: urlBack+route) else {
            print("pb url")
            return
        }
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let encoded = await JSONHelper.encode(data: dtoElement) else {
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
    
    //MODIFY
    
    static func modify<T: Encodable>(route : String, dtoElement : T) async{
        guard let url = URL(string: urlBack+route) else {
            print("pb url")
            return
        }
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let encoded = await JSONHelper.encode(data: dtoElement) else {
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
    
    //DELETE
    
    
}
