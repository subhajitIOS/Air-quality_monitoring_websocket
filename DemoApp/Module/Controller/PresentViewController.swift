//
//  PresentViewController.swift
//  DemoApp
//
//  Created by Subhajit Mondal on 6/12/21.
//  Copyright © 2021 Subhajit Mondal. All rights reserved.
//

import UIKit
//import SwiftUI
class PresentViewController: UIViewController {

    var viewModel : PresentViewModel = PresentViewModel()
    var refreshControl: UIRefreshControl!

    @IBOutlet weak var mapTable: UITableView!{
        didSet{
            mapTable.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
            addRefreshControl()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.startConnection()
        // Do any additional setup after loading the view.
    }
    
    private func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.gray
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        mapTable.refreshControl = refreshControl
    }
    
    @objc func refresh(){
        self.refreshControl.endRefreshing()
        self.mapTable.reloadData()
    }

}

extension PresentViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        
        cell.selectionStyle = .none
        if let model = self.viewModel.modelForRow(at: indexPath) {
            cell.config(data: model)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension PresentViewController : PresentViewModelProtocol {
    func reloadTableview() {
        self.mapTable.reloadData()
    }
}
