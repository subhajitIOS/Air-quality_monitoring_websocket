

import Foundation

protocol PresentViewModelProtocol : AnyObject {
    func reloadTableview()
}

class PresentViewModel{
    
    weak var delegate : PresentViewModelProtocol?
    private var session = URLSession(configuration: .default)
    private var socket: URLSessionWebSocketTask!
    private var dataSource = [Datamodel]()
    
    private func connect() {
      self.socket = session.webSocketTask(with: URL(string: "ws://city-ws.herokuapp.com/")!)
      self.listen()
      self.socket.resume()
    }
    
    private func listen() {
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
           case .data(_):
            // self.handle(data)
            print("failed")
           case .string(let str):
            guard let data = str.data(using: .utf8) else { return }
             self.handleString(data)
           @unknown default:
             break
           }
         }
         // 5
         self.listen()
       }
     }
    
    private func handleString(_ data1: Data) {
        do {
            let jsonDecoder = JSONDecoder()
            let empData = try jsonDecoder.decode([Datamodel].self, from: data1)
            insertOrUpdateDatainDataSource(dataArray: empData)
            DispatchQueue.main.async {
                self.delegate?.reloadTableview()
            }
        } catch {
            print(error)
        }
    }
    
    private func insertOrUpdateDatainDataSource(dataArray : [Datamodel]){
        for data in dataArray {
            if let index = dataSource.firstIndex(where: {$0.city == data.city}) {
                let timestamp = Date().currentTimeMillis()
                var previousData  =  self.dataSource[index]
                previousData.timeStamp =  timestamp
                previousData.aqi = data.aqi
                self.dataSource[index] = previousData
            }
            else{
                self.dataSource.append(data)
            }
        }
    }
}

// controller
extension PresentViewModel {
    func startConnection(){
        connect()
    }
    
    func numberOfRows(in section: Int) -> Int{
        return dataSource.count
    }
    
    func modelForRow(at indexPath : IndexPath) -> Datamodel? {
        if dataSource.count > indexPath.row{
            return dataSource[indexPath.row]
        }
        else{
            return nil
        }
    }
}
