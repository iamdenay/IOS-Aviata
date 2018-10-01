
import Foundation
import ObjectMapper

class MovieImage : Mappable {
    var filePath:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        filePath <- map["file_path"]
    }
}
