import SwiftUI

struct EtapeDTO : Codable, Hashable {
    var id_etape : Int?
    var titre_etape : String
    var temps_etape : Double
    var description_etape : String
    
    static func toEtape(data: [EtapeDTO]) -> [Etape]?{
          var etape_list = [Etape]()
          for tdata in data{
             guard (tdata.id_etape != nil) else{
                return nil
             }
             let id : Int = tdata.id_etape ?? tdata.id_etape!
              let etape = Etape(id_etape: id, titre_etape: tdata.titre_etape, temps_etape: tdata.temps_etape, description_etape: tdata.description_etape)
              etape_list.append(etape)
          }
    return etape_list
    }
}

