//
//  DataTableViewCell.swift
//  DemoApp
//
//  Created by Debayan Bhattacharya on 6/13/21.
//  Copyright © 2021 Debayan Bhattacharya. All rights reserved.
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
        
        print(data.timeStampPrevious)
        if let previousSecond = data.timeStampPrevious{
            if let current =  data.timeStampCurrent{
                    var dateGet = Date(timeIntervalSince1970: (Double(previousSecond) / 1000.0))
                var datecurrent = Date(timeIntervalSince1970: (Double(current) / 1000.0))
                           
                         
                           
                          let str =  timeAgoSince(dateGet, datecurrent)
                          
                
                timeLbl.text = str
            }
           
            
        }
       
        
        
        if let percent = data.aqi , percent >= 0  && 50 >= percent {
              valueLbl.backgroundColor = UIColor(red: 70/255, green: 155/255, blue: 62/255, alpha: 1.0)
             timeLbl.backgroundColor = UIColor(red: 70/255, green: 155/255, blue: 62/255, alpha: 1.0)
             cityLbl.backgroundColor = UIColor(red: 70/255, green: 155/255, blue: 62/255, alpha: 1.0)
        }
        else if let percent = data.aqi , percent >= 51  && 100 >= percent {
              valueLbl.backgroundColor = UIColor(red: 148/255, green: 192/255, blue: 66/255, alpha: 1.0)
             timeLbl.backgroundColor = UIColor(red: 148/255, green: 192/255, blue: 66/255, alpha: 1.0)
             cityLbl.backgroundColor = UIColor(red: 148/255, green: 192/255, blue: 66/255, alpha: 1.0)
              }
        else if let percent = data.aqi , percent >= 101  && 200 >= percent {
              valueLbl.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 40/255, alpha: 1.0)
             timeLbl.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 40/255, alpha: 1.0)
             cityLbl.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 40/255, alpha: 1.0)
              }
         else if let percent = data.aqi , percent >= 201  && 300 >= percent {
              valueLbl.backgroundColor =  UIColor(red: 236/255, green: 138/255, blue: 40/255, alpha: 1.0)
             timeLbl.backgroundColor = UIColor(red: 236/255, green: 138/255, blue: 40/255, alpha: 1.0)
             cityLbl.backgroundColor = UIColor(red: 236/255, green: 138/255, blue: 40/255, alpha: 1.0)
              }
         else if let percent = data.aqi , percent >= 301  && 400 >= percent {
              valueLbl.backgroundColor = UIColor(red: 225/255, green: 40/255, blue: 39/255, alpha: 1.0)
             timeLbl.backgroundColor = UIColor(red: 225/255, green: 40/255, blue: 39/255, alpha: 1.0)
             cityLbl.backgroundColor = UIColor(red: 225/255, green: 40/255, blue: 39/255, alpha: 1.0)
              }
       else if let percent = data.aqi , percent >= 400  && 500 >= percent {
              valueLbl.backgroundColor = UIColor(red: 157/255, green: 28/255, blue: 27/255, alpha: 1.0)
             timeLbl.backgroundColor = UIColor(red: 157/255, green: 28/255, blue: 27/255, alpha: 1.0)
             cityLbl.backgroundColor = UIColor(red: 157/255, green: 28/255, blue: 27/255, alpha: 1.0)
              }
        
        
      
        
    }
    func timeAgoSince(_ date: Date,_ current: Date) -> String {
       
       let calendar = Calendar.current
       let now = Date()
       let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
       let components = (calendar as NSCalendar).components(unitFlags, from: date, to: current, options: [])
       
       if let year = components.year, year >= 2 {
           return "\(year) years ago"
       }
       
       if let year = components.year, year >= 1 {
           return "Last year"
       }
       
       if let month = components.month, month >= 2 {
           return "\(month) months ago"
       }
       
       if let month = components.month, month >= 1 {
           return "Last month"
       }
       
       if let week = components.weekOfYear, week >= 2 {
           return "\(week) weeks ago"
       }
       
       if let week = components.weekOfYear, week >= 1 {
           return "Last week"
       }
       
       if let day = components.day, day >= 2 {
           return "\(day) days ago"
       }
       
       if let day = components.day, day >= 1 {
           return "Yesterday"
       }
       
       if let hour = components.hour, hour >= 2 {
           return "\(hour) hours ago"
       }
       
       if let hour = components.hour, hour >= 1 {
           return "An hour ago"
       }
       
       if let minute = components.minute, minute >= 2 {
           return "\(minute) minutes ago"
       }
       
       if let minute = components.minute, minute >= 1 {
           return "A minute ago"
       }
       
       if let second = components.second, second >= 3 {
           return "\(second) seconds ago"
       }
       
       return "Just now"
       
   }

}
