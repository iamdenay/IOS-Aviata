
import Foundation
import ObjectMapper

class Actor : Mappable {
    var name:String?
    var character:String?
    var profile_path:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        character <- map["character"]
        name <- map["name"]
        profile_path <- map["profile_path"]
    }
}
