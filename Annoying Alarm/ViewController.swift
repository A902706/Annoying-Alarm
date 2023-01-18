//
//  ViewController.swift
//  Annoying Alarm
//
//  Created by Andres Sanchez on 10/13/22.
//
import UIKit
import AVFoundation

class ViewController: UIViewController {
    // ALL OUTLETS the go to a button
    //Counter counter name input textfield
    @IBOutlet weak var eventNameTextField: UITextField!
    //DatePicker select
    @IBOutlet weak var eventDateSelectDatePicker: UIDatePicker!
    //displays the label of textField
    @IBOutlet weak var eventNameLabel: UILabel!
    //displays the label of the datePikcker
    @IBOutlet weak var eventDateLabel: UILabel!
    //The number of days displayed by the countdown counter
    @IBOutlet weak var dayOfEventCountLabel: UILabel!
    //The hour displayed by the countdown
    @IBOutlet weak var hoursOfEventCountLabel: UILabel!
    //The minutes displayed by the countdown
    @IBOutlet weak var minutesOfEventCountLabel: UILabel!
    //The seconds displayed by the countdown
    @IBOutlet weak var secondsOfEventCountLabel: UILabel!
    //Question view
    @IBOutlet weak var questionPortion: UITextField!
    //Answer portion
    @IBOutlet weak var answerPortion: UITextField!
    
    //Define timer for countdown time
    var timer : Timer?
    
    var player: AVAudioPlayer?
    //this func calls sound
    func playSound() {
        let url = Bundle.main.url(forResource: "alarmclock", withExtension: "mp3")!

        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }

            player.prepareToPlay()
            player.numberOfLoops = -1
            player.play()
            
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    
    //Prints question Ex: 1+1 through raandom gen
    func question() {
        let numberOne = Int.random(in: 1..<50)
        let numberTwo = Int.random(in: 1..<13)
        let opperator = Int.random(in: 1..<3)
        self.questionPortion.isHidden = false
        self.answerPortion.isHidden = false
        let answer = numberOne + numberTwo
        
        if opperator == 1{
            self.questionPortion.text = "what is \(numberOne) + \(numberTwo) Enter Below"
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                let guess = self.answerPortion.text
                print(guess!)
                    
                    if "\(answer)" == "\(guess!)" {
                        self.timer?.invalidate()
                        self.player?.stop()
                        self.questionPortion.isHidden = true
                        self.answerPortion.isHidden = true
                        print("OMG WORKS1")
                        
                    }
            }
        }
         
        else if opperator == 2{
            self.questionPortion.text = "what is \(numberOne) - \(numberTwo) Enter Below"
            let answer = numberOne - numberTwo
            print(answer)
            let guess = self.answerPortion.text
              print(guess!)
                if "\(answer)" == "\(guess!)" {
                    self.timer?.invalidate()
                    self.player?.stop()
                    self.questionPortion.isHidden = true
                    self.answerPortion.isHidden = true
                    print("OMG WORKS2")
                
                }
            
        }
        else{
            print("fix me pls")
        }
        
    }
    
    
    
    //Hides keybord stuff if something is tapped around
    func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
    view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Click anywhere to close the keyboard
        self.hideKeyboardWhenTappedAround()
    }

    func dateCountStart() {
        
        //Assign the "date" selected by datepicker to eventDate
        let eventDate = eventDateSelectDatePicker.date
        
        
        
        //Let eventDateLabel display the time selected by datepicker
        
        //Defineing the formatter
        let formatter = DateFormatter()
        //THis displays date formatt yyyy/mm/dd
        formatter.dateFormat = "mm/dd/yy"
        //THis displays content of .dateFormat to showTOLabelDate "label"
        //The time obtained by showTOLabelDate is based on the date picker assigned to eventDate
        let showTOLabelDate = formatter.string(from: eventDate)
        //Display the format of the processed time into a string on eventDateLabel (display the label of the selected time)
        eventDateLabel.text = showTOLabelDate
        
        
        
        //calculates & starts countdown
        //then cancel the original timer
        if let timer = timer {
            timer.invalidate()
        }
        
        //Enable the timer trigger event it checks the interval is every second
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            
            // use the time difference between current datepicker and datepicker through .timeIntervalSinceNow
            //Assign to interval
            let interval = Int(eventDate.timeIntervalSinceNow)
            
            // Get the remainder of the time difference in seconds
            let eventSconds = interval % 60
            //Get the remainder of the minutes of the time difference
            let eventMinutes = interval / 60 % 60
            
            // Get the remainder of the hour of the time difference
            let eventHours = interval / 60 / 60 % 24
            
            // Get the number of days of time difference
            let eventDay = interval / 60 / 60 / 24
            
            //Assign the remaining "days", "hours", "minutes" and "seconds"
            self.secondsOfEventCountLabel.text = "\(eventSconds) Sec"
            self.minutesOfEventCountLabel.text = "\(eventMinutes) Min"
            self.hoursOfEventCountLabel.text = "\(eventHours) Hour"
            self.dayOfEventCountLabel.text = "\(eventDay) Day"
    
         //this is a parameter which is kinda a "trigger"
         //This also stops timmer and plays sound
         //Plan to add a popup
            if  (eventSconds, eventMinutes, eventHours, eventDay) == (0,0,0,0){
                self.timer?.invalidate()
                // test to see if works
                    print("pro");
               // self.player?.volume = 100
                self.playSound()
                self.question()
              
            
            }
        }
        
    }
    
    
    //BELOW are Action functions
    //custom dateCountStart
    @IBAction func dateSelect(_ sender: Any) {
        //excutes when writtendateCountStart()function
        dateCountStart()
    }
   
    @IBAction func  answer(_ sender: Any) {
        view.endEditing(true)
        
    }
    // UITextField action
    @IBAction func eventNameWrite(_ sender: Any) {
        //Press return to close the keyboard
        view.endEditing(true)
        
        //Assign the content of textfield to NameTextField
        eventNameLabel.text = eventNameTextField.text
    }
    
    
}

