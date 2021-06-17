//
//  DataTableViewCell.swift
//  DemoApp
//
//  Created by Subhajit Mondal on 6/13/21.
//  Copyright © 2021 Subhajit Mondal. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
      
        // Initialization code
    }

   
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var valueLbl: UILabel!
    
    @IBOutlet weak var cityLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(data: Datamodel) {
        cityLbl.text = data.city
        valueLbl.text = String(format: "%.2f", data.aqi!)
        
        let dateGet = Date(timeIntervalSince1970: (Double(data.timeStamp) / 1000.0))
        let datecurrent = Date()
        
        let str =  datecurrent.timeAgoSince(dateGet)
        timeLbl.text = str
        
        let airQuality = AirQuality.getAirQualityFor(aqi: data.aqi ?? 0)
        
        valueLbl.backgroundColor = airQuality.getLabelColor()
        timeLbl.backgroundColor = airQuality.getLabelColor()
        cityLbl.backgroundColor = airQuality.getLabelColor()
    }
}


enum AirQuality {
    case good, satisfactory, moderate, poor, veryPoor, severe
    
    static func getAirQualityFor(aqi : Double) -> AirQuality {
        if aqi < 51 {
            return .good
        }
        else if aqi < 101 {
            return .satisfactory
        }
        else if aqi < 201 {
            return .moderate
        }
        else if aqi < 301 {
            return .poor
        }
        else if aqi < 401 {
            return .veryPoor
        }
        else {
            return .severe
        }
    }
    
    func getLabelColor() -> UIColor {
        switch self {
        case .good:
            return UIColor(red: 70.0/255.0, green: 155.0/255.0, blue: 62.0/255.0, alpha: 1.0)
        case .satisfactory:
            return UIColor(red: 148/255, green: 192/255, blue: 66/255, alpha: 1.0)
        case .moderate:
            return UIColor(red: 254/255, green: 250/255, blue: 40/255, alpha: 1.0)
        case .poor:
            return UIColor(red: 236/255, green: 138/255, blue: 40/255, alpha: 1.0)
        case .veryPoor:
            return UIColor(red: 225/255, green: 40/255, blue: 39/255, alpha: 1.0)
        case .severe:
            return UIColor(red: 157/255, green: 28/255, blue: 27/255, alpha: 1.0)
        }
    }
}
