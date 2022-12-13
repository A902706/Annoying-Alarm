//
//  ViewController.swift
//  Annoying Alarm
//
//  Created by Andres Sanchez on 10/13/22.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer?

  @IBOutlet weak var dateTextField: UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()
      //UIDatePicker
    dateTextField.delegate = self
      //timer
      timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(actionCode), userInfo: nil, repeats: true)
  }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    @objc func actionCode() {

        // get the current date and time
        let currentDateTime = Date()

        // get the user's calendar
        let userCalendar = Calendar.current
      

        //date component
        let requestedComponents: Set<Calendar.Component> = [.year,.month,.day,.hour,.minute,.second]
   

        // callss the components
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)

        print(userCalendar)
        print(dateTimeComponents)

    }
}


extension ViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    self.openDatePicker()
  }
}

  //If dateTextField is tapped/clicked it will run the rest of this code
  //Code Below makes the date picker apear
extension ViewController {
    func openDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(self.datePickerHandler(datePicker:)), for: .valueChanged)
        dateTextField.inputView = datePicker
        
        // Creates Tool Bar, Cancel Button, AND Done Button
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 44))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelButtonClick))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonClick))
        //Buttons Done & Cancel will be spaced evenly from one side to another using fexible attribute
        let SpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelButton, SpaceButton, doneButton], animated: false)
        
        dateTextField.inputAccessoryView = toolbar
    }
    //This says IF the cancel button is clicked/tapped close the datpicker
    @objc func cancelButtonClick() {
        dateTextField.resignFirstResponder()
    }
    //This tells IF "Done" button is clicked/tapped display the Date/time chosen
    @objc func doneButtonClick() {
        if let datePicker = dateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy, hh:mm"
            dateTextField.text = dateFormatter.string(from: datePicker.date)
            print(datePicker.date)
        }
        dateTextField.resignFirstResponder()
    }
    
    @objc func datePickerHandler(datePicker: UIDatePicker) {
        print(datePicker.date)
    }
}

