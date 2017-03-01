//
//  ViewController.swift
//  AlarmoFireStart
//
//  Created by Vansa Pha on 3/1/17.
//  Copyright © 2017 Vansa Pha. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var MY_API_KEY="Basic c2V5aGE6Z3JvdXAyMTIzNDU2"
    var API_URL="http://120.136.24.174:1304/api/address/get-address"
    var dataArr=[AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAlamofire(urlString: API_URL)
    }
    
    func callAlamofire(urlString:String) {
        let headers: HTTPHeaders = [
            "Authorization": MY_API_KEY,
            "Accept": "application/json"
        ]
        
        Alamofire.request(urlString, headers: headers).responseJSON { response in
            let result=response.result.value
            if let dict=result as? Dictionary<String, AnyObject>{
                if let innerDict=dict["DATA"]{
                    self.dataArr=innerDict as! [AnyObject]
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as? AddressTableViewCell{
            cell.txtStreet.text=self.dataArr[indexPath.row]["street"] as? String
            cell.txtDistrict.text=self.dataArr[indexPath.row]["district"] as? String
            cell.txtProvince.text=self.dataArr[indexPath.row]["province"] as? String
            return cell
        }
        return UITableViewCell()
    }
    
}

