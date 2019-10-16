//
//  ViewController.swift
//  SPHTest
//
//  Created by YAP HAO XUAN on 04/10/2019.
//  Copyright © 2019 YAP HAO XUAN. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data : NSArray! = []
    
    var displayData : [String:String] = [:]
    
    var yearData = [String]()
    
    var numberData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.tableFooterView = UIView()
        
        getData()
    }


    func getData()
    {
        let parameters: Parameters = [:]
        
        APIManager.callAPI(view: self.view, type: .get, requestPath: "", queryString: "", parameters: parameters, OnSuccess: { (data, code) in
//            print("data" , data)
            self.data = (data as AnyObject).value(forKeyPath: "result.records") as? NSArray
//            print(self.data)
            
            for i in self.data {
                let quater = (i as AnyObject).value(forKeyPath: "quarter") as! String
                let volume_of_mobile_data = (i as AnyObject).value(forKeyPath: "volume_of_mobile_data") as! String
                let key = String(quater.prefix(4))
                let keyExists = self.displayData[key] != nil
                
                if keyExists
                {
                    
                    let data = self.displayData[key]
                    let sum = Float(data!)! + Float(volume_of_mobile_data)!
                    self.displayData.updateValue(String(sum), forKey: key)
                    
                }
                else
                {
                    self.displayData.updateValue(volume_of_mobile_data, forKey: key)
                }
            }
            let sortedKeys = Array(self.displayData.keys).sorted(by: <) // ["A", "D", "Z"]
            let sorted = self.displayData.sorted { $0.key < $1.key }
            self.yearData = Array(sorted.map({ $0.key }))
            self.numberData = Array(sorted.map({ $0.value }))

            self.tableView.reloadData()

        }) { (nil, error) in
            print("Get Data Fail")
        }
    }
    
}

extension ViewController: UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        let key   = self.yearData[indexPath.row]
        let value = self.numberData[indexPath.row]
        
        selectedCell.displayLabel.text = key + " " + value
        return selectedCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
   
    }
    
    //handle pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

