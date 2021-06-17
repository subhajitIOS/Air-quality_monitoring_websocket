
import Foundation

public struct Datamodel : Decodable {
    var city : String?
    var aqi : Double?
    var timeStamp : Int64 = Date().currentTimeMillis()
    
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case aqi = "aqi"
    }
}
