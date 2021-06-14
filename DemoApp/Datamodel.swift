
import Foundation

public class Datamodel {
	public var city : String?
	public var aqi : Double?
      public var timeStampPrevious : Int64?
    public var timeStampCurrent : Int64?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Datamodel]
    {
        var models:[Datamodel] = []
        for item in array
        {
            models.append(Datamodel(dictionary: item as! NSDictionary)!)
        }
        return models
    }


	required public init?(dictionary: NSDictionary) {

		city = dictionary["city"] as? String
		aqi = dictionary["aqi"] as? Double
        timeStampPrevious = dictionary["timeStampPrevious"] as? Int64
        timeStampCurrent = dictionary["timeStampCurrent"] as? Int64
	}

		
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.city, forKey: "city")
		dictionary.setValue(self.aqi, forKey: "aqi")
        dictionary.setValue(self.timeStampCurrent, forKey: "timeStampCurrent")
        dictionary.setValue(self.timeStampPrevious, forKey: "timeStampPrevious")

		return dictionary
	}

}
