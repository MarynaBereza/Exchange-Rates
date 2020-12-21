//
//  ExchageRateVC.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 10/21/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import UIKit

protocol DateRefreshHandler {

    func refreshWith(date: Date)
}

protocol CompactSizeSupported {
    
    func compactSizeSupported(_ compact: Bool)
}

class ExchageRateVC: UIViewController, DatePickerViewControllerDelegate {
    
    var buttonPrivatSelected: Bool = false;
    let coreDataStack = CoreDataStack.instance
    let dateFormattre = DateFormatter()
    var currentDate = Date()
    
    let indiator = UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var hidePrivatRatesButton: UIButton!
    @IBOutlet weak var privatView: UIView!
    @IBOutlet weak var privatContainerHeightConstraint: NSLayoutConstraint!
    
    var privatContentHeight: CGFloat = 0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: nil) { (notification) in
            
            print("app did enter background")
            self.coreDataStack.saveContext()
        }
        
        self.dateFormattre.dateFormat = "dd.MM.yyyy"

        let dateStr = dateFormattre.string(from: currentDate)
        self.calendarButton.setTitle("\(dateStr)", for: .normal)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    // MARK: - Action
    
    
    @IBAction func actionHidePrivateRates(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        buttonPrivatSelected = sender.isSelected
        
        print(sender.isSelected)
        
        children.forEach { (childVC) in
            
            if let child = childVC as? CompactSizeSupported {
                
                child.compactSizeSupported(sender.isSelected)
            }
        }
    }
    
    @IBAction func actionCalendar(_ sender: UIButton) {
        
        let datePickerVC: DatePickerVC = storyboard?.instantiateViewController(identifier: "DatePickerVC") as! DatePickerVC
        
        datePickerVC.datePickerDelegate = self

        self.present(datePickerVC, animated: true, completion: nil)
        datePickerVC.datePicker.setDate(currentDate, animated: true)
        
        let currentDate = Date()
        let calendarGreg = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.calendar = calendarGreg
        
        let maxDate = calendarGreg.date(byAdding: components, to: currentDate )!
        
        components.year = -3
        let minDate = calendarGreg.date(byAdding: components, to: currentDate )!
        
        datePickerVC.datePicker.maximumDate = maxDate
        datePickerVC.datePicker.minimumDate = minDate
    }
    
 // MARK: - UIContentContainer Method
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {

        privatContentHeight = container.preferredContentSize.height
        
        privatContainerHeightConstraint.constant = privatContentHeight
        
        self.view.layoutIfNeeded()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
            
            self.hidePrivatRatesButton.isEnabled = false
            self.hidePrivatRatesButton.tintColor = .clear
            
        } else {
            
            children.forEach { (childVC) in
                
                if let child = childVC as? CompactSizeSupported {
                    
                    child.compactSizeSupported(buttonPrivatSelected)
                }
            }
            
            self.hidePrivatRatesButton.isEnabled = true
            self.hidePrivatRatesButton.tintColor = .white
        }
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Date Picker Delegate
    
    func datePickerViewController( vc: UIViewController, dateDidChanched datePickerValue: Date) {
        
        self.currentDate = datePickerValue
        
        calendarButton.setTitle(dateFormattre.string(from: self.currentDate), for: .normal)
        
        children.forEach { (childVC) in
            if let child = childVC as? DateRefreshHandler {
                
                child.refreshWith(date: datePickerValue)
            }
        }
    }
}
    

