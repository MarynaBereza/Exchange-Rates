//
//  privatBankTVC.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 10/22/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import UIKit

class PrivatBankTVC: UITableViewController {
    let coreDataStack = CoreDataStack.instance
    
    let activityIndicator = UIActivityIndicatorView(style: .large)

    var privatRatesArray = [PrivatRate]()
    let compactRowsCount: CGFloat = 3
    var dateForRefresh = Date()

    var contentSize = CGSize.zero {
        didSet {
            if contentSize == oldValue {
                return
            }
            self.preferredContentSize = self.contentSize
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Repository.getPrivatCurrencyRatesDataBy( date: dateForRefresh, completion: {[weak self] array in
            
           guard let weakSelf = self else {
               return
           }
            weakSelf.view.addSubview(weakSelf.activityIndicator)
            weakSelf.activityIndicator.color = UIColor.init(displayP3Red: 67.0/255.0, green: 165.0/255.0, blue: 79.0/255.0, alpha: 1.0)
            weakSelf.activityIndicator.center = weakSelf.view.center
            weakSelf.activityIndicator.startAnimating()
        
            weakSelf.privatRatesArray = array
            weakSelf.tableView.reloadData()
            weakSelf.activityIndicator.stopAnimating()
        })
        tableView.register(UINib(nibName: "PrivatBankTVCell", bundle: nil), forCellReuseIdentifier: "PrivatBankTVCell")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.privatRatesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rate = self.privatRatesArray[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "PrivatBankTVCell", for: indexPath) as! PrivatBankTVCell
        
        cell.nameLabel.text = rate.name
        cell.buyValueLabel.text = String(rate.buy)
        cell.saleValueLabel.text =  String(rate.sale)

        return cell
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        self.tableView.invalidateIntrinsicContentSize()

        self.contentSize = self.tableView.contentSize
        
        self.tableView.reloadData()
    }
    
     // MARK: - Table view Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PrivatBankTVC: DateRefreshHandler {
    
    func refreshWith(date: Date) {
        
        self.dateForRefresh = date
        activityIndicator.startAnimating()
        Repository.getPrivatCurrencyRatesDataBy(date: dateForRefresh, completion: {[weak self] array in
            
            guard let weakSelf = self else {
                return
            }
            weakSelf.privatRatesArray = array
            weakSelf.tableView.reloadData()
            weakSelf.activityIndicator.stopAnimating()
        })
        self.tableView.reloadData()
    }
}


extension PrivatBankTVC: CompactSizeSupported {
    
    func compactSizeSupported(_ compact: Bool) {
        
        if !compact {
            self.contentSize.height = self.contentSize.height / CGFloat(privatRatesArray.count) *  compactRowsCount
        } else {
            self.contentSize = self.tableView.contentSize
        }
    }
}

