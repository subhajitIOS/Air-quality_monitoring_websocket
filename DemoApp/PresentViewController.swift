//
//  PresentViewController.swift
//  DemoApp
//
//  Created by Debayan Bhattacharya on 6/12/21.
//  Copyright © 2021 Debayan Bhattacharya. All rights reserved.
//

import UIKit
import SwiftUI
class PresentViewController: UIViewController {
    var data = [Datamodel]()
  
    @IBOutlet weak var mapTable: UITableView!
    var session = URLSession(configuration: .default)
    var socket: URLSessionWebSocketTask!
    override func viewDidLoad() {
        super.viewDidLoad()
      mapTable.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
       self.connect()
        
        // Do any additional setup after loading the view.
    }
    func connect() {
      self.socket = session.webSocketTask(with: URL(string: "ws://city-ws.herokuapp.com/")!)
      self.listen()
      self.socket.resume()
    }
  
        
    func listen() {
       // 1
       self.socket.receive { [weak self] (result) in
         guard let self = self else { return }
         // 2
         switch result {
         case .failure(let error):
           print(error)
           // 3
         
           return
         case .success(let message):
           // 4
           switch message {
           case .data(let data):
            // self.handle(data)
            print("")
           case .string(let str):
             guard let data = str.data(using: .utf8) else { return }
             self.handleString(str)
           @unknown default:
             break
           }
         }
         // 5
         self.listen()
       }
     }
     
    func handleString(_ data: String) {
           do {
             // 1
            let data1 = data.data(using: .utf8)!
              do {
                  if let jsonArray = try JSONSerialization.jsonObject(with: data1, options : .allowFragments) as? [Dictionary<String,Any>]
                  {
                    
                    
                    for data in jsonArray {
                        guard let data = Datamodel.init(dictionary: data as NSDictionary) else { return }
                        
                       
                        if let index = self.data.firstIndex(where: {$0.city == data.city}) {
                             let timestamp = Date().currentTimeMillis()
            
                            let previousData  =  self.data[index]
                            print("current",previousData.timeStampCurrent ?? 0)
                            data.timeStampPrevious =  previousData.timeStampCurrent
                             data.timeStampCurrent = timestamp
                            self.data[index] = data
                           
                        }
                        else{
                            
                             let timestamp = Date().currentTimeMillis()
                            data.timeStampCurrent = timestamp
                            data.timeStampPrevious = timestamp
                             self.data.append(data)
                           
                        }
                        //let index =  self.data.firstIndex{$0.city as AnyObject? === data.city as AnyObject?}
                        
                       
                      
    //                let data = Datamodel.modelsFromDictionaryArray(array: jsonArray as NSArray)
                    }
                   // self.data.append(contentsOf: data)
                    // use the json here
                 
                    DispatchQueue.main.async {
                        self.mapTable.reloadData()
                    }
                  
                    
                    
                  } else {
                      print("bad json")
                  }
              } catch let error as NSError {
                  print(error)
              }
          

        print(data)
           } catch {
             print(error)
           }
         }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
extension PresentViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        
        cell.selectionStyle = .none
        
        cell.config(data: self.data[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

//        if (orders.count > 8){
//            let lastElement = self.orders.count - 1
//
//            if indexPath.row == lastElement {
//
//                start += 10
//                dataFetch()
//                // handle your logic here to get more items, add it to dataSource and reload tableview
//            }
//        }

        // use as? or as! to cast UITableViewCell to your desired type
    }

    
    
    
}
