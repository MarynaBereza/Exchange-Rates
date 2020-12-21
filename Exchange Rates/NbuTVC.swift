//
//  TableViewController.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 10/22/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import UIKit


class NbuTVC: UITableViewController {
    
    var nbuRatesArray = [NbuRate]()
    var dateForRefresh = Date()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Repository.getNbuCurrencyRatesDataBy(date: dateForRefresh) { [weak self](array) in
            guard let weakSelf = self else {
                return
            }
            
            weakSelf.view.addSubview(weakSelf.activityIndicator)
            weakSelf.activityIndicator.center = weakSelf.view.center
//            weakSelf.activityIndicator.color = UIColor.init(displayP3Red: 67.0/255.0, green: 165.0/255.0, blue: 79.0/255.0, alpha: 1.0)
            weakSelf.activityIndicator.startAnimating()
            
            weakSelf.nbuRatesArray = array
            weakSelf.tableView.reloadData()
            weakSelf.activityIndicator.stopAnimating()
        }
        tableView.register(UINib(nibName: "NbuTVCell", bundle: nil), forCellReuseIdentifier: "NbuTVCell")
    }
    
    
//    // MARK: - Method get data fron Server
//
//    func getRatesFromServerWithDate(date: Date) {
//
//        Repository.getNbuCurrencyRatesDataBy(date: date) { [weak self](nbuRatesArray) in
//            guard let weakSelf = self else {
//                return
//            }
//            weakSelf.view.addSubview(weakSelf.activityIndicator)
//            weakSelf.activityIndicator.center = weakSelf.view.center
//            weakSelf.activityIndicator.color = UIColor.init(displayP3Red: 67.0/255.0, green: 165.0/255.0, blue: 79.0/255.0, alpha: 1.0)
//            weakSelf.activityIndicator.startAnimating()
//            weakSelf.nbuRatesArray = nbuRatesArray
//
//            weakSelf.tableView.reloadData()
//            weakSelf.activityIndicator.stopAnimating()
//        }
//        tableView.register(UINib(nibName: "NbuTVCell", bundle: nil), forCellReuseIdentifier: "NbuTVCell")
//    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nbuRatesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rate = nbuRatesArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NbuTVCell", for: indexPath) as! NbuTVCell
        cell.rateNameLabel.text = rate.longName
        cell.valueRaleLabel.text = String(rate.rate)
        cell.shortNameRateLabel.text = rate.shortName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Extension

extension NbuTVC: DateRefreshHandler {
    
    func refreshWith(date: Date) {
        self.dateForRefresh = date
        self.activityIndicator.startAnimating()
        
        Repository.getNbuCurrencyRatesDataBy(date: dateForRefresh) { [weak self](array) in
            
            guard let weakSelf = self else {
                return
            }
            weakSelf.nbuRatesArray = array
            weakSelf.tableView.reloadData()
            weakSelf.activityIndicator.stopAnimating()
        }
    }
}
