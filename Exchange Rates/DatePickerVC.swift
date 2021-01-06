//
//  DatePickerViewC.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 10/26/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import UIKit


protocol DatePickerViewControllerDelegate {
    
    func datePickerViewController( vc: UIViewController, dateDidChanched pickerValue: Date)
}

class DatePickerVC: UIViewController {
    
    let dateFormatter = DateFormatter()
    
    var datePickerDelegate:DatePickerViewControllerDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        self.datePicker.calendar = Calendar.current
        self.datePicker.timeZone = TimeZone(secondsFromGMT: 2)
    }
    
    // MARK: - Action
    
    @IBAction func actionCancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionOk(_ sender: UIButton) {
        
        self.datePickerDelegate?.datePickerViewController(vc: self, dateDidChanched: datePicker.date)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        
        let date = sender.date
        print(dateFormatter.string(from: date))
    }
}
