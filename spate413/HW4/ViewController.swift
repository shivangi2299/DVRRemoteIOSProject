//
//  ViewController.swift
//  HW4
//
//  Created by Rohan Panchal on 1/29/24.
//

import UIKit

class ViewController: UIViewController {
    var originalTitles = ["POGO", "Star Sports", "NBC", "Nature"]
    var originalValues = [07, 01, 02, 32]
    override func viewDidLoad() {
        super.viewDidLoad()
        channelValue.text = "50"
        // Do any additional setup after loading the view.
        powervalue.accessibilityIdentifier = "TV_Power_Value"
        
        volumeValue.accessibilityIdentifier = "TV_Speaker_Volume_Value"
        
        channelValue.accessibilityIdentifier = "Current_Channel_Value"
        powerSwitch.accessibilityIdentifier = "Power_Switch"
        volumeslider.accessibilityIdentifier = "Volume_Slider"
        favouriteChannel.accessibilityIdentifier = "Favorite_Channel_Segmented_Control"
        for (index, title) in originalTitles.enumerated() {
                    favouriteChannel.setTitle(title, forSegmentAt: index)
                }
       
        powerOff()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
        self.favouriteChannel.setTitle(DataModel.shared.text, forSegmentAt: DataModel.shared.segment)
        originalValues[DataModel.shared.segment] = DataModel.shared.ChanNo
    }

    var channelnumber : Int = 50
    var isFirst = true
    var firstNumber = 0
    var secondNumber = 0
    
    
    @IBOutlet weak var powerSwitch: UISwitch!
    
    @IBOutlet weak var volumeslider: UISlider!
    
    @IBOutlet weak var powervalue: UILabel!
    
    @IBOutlet weak var volumeValue: UILabel!
    
    @IBOutlet weak var channelValue: UILabel!
    
    @IBOutlet weak var favouriteChannel: UISegmentedControl!
    
    @IBOutlet var channelButton: [UIButton]!
    
    
    
        func powerOn(){        
        volumeslider.isEnabled = true
        
            for index in 0..<favouriteChannel.numberOfSegments {
                  favouriteChannel.setEnabled(true, forSegmentAt: index)
              }
        for case let button as UIButton in channelButton {
            button.isEnabled = true
        }
        
    }
    
    func powerOff(){
        volumeslider.isEnabled = false
        
        for index in 0..<favouriteChannel.numberOfSegments {
              favouriteChannel.setEnabled(false, forSegmentAt: index)
          }
        for case let button as UIButton in channelButton {
            button.isEnabled = false
        }
        
    }
    
    
    
    @IBAction func switchToggled(_ sender: UISwitch ) {
        powervalue.text = (sender.isOn ? "On" : "Off")
        powerSwitch.setOn(sender.isOn, animated: true)
        sender.isOn ?  powerOn() : powerOff()
        
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        volumeValue.text = "\(Int(sender.value))"
    }
    

    @IBAction func favPicks(_ sender: UISegmentedControl) {
        
       // if let name = sender.titleForSegment(at: sender.selectedSegmentIndex) {
//                    if name == "POGO"{
//                        channelValue.text = "07"
//                        channelnumber = 07
//                    }
//                    else if name == "Star Sports" {
//                        channelValue.text = "05"
//                        channelnumber = 05
//                    }
//                    
//                    else if name == "NBC" {
//                        channelValue.text = "02"
//                        channelnumber = 02
//                    }
//                    else if name == "Nature" {
//                        channelValue.text = "32"
//                        channelnumber = 32
//                    }
//                }
        
        
        if sender.selectedSegmentIndex == 0 {
            channelValue.text = "\(originalValues[0])"
            channelnumber = originalValues[0]
        } else if sender.selectedSegmentIndex == 1{
            channelValue.text = "\(originalValues[1])"
            channelnumber = originalValues[1]
        }else if sender.selectedSegmentIndex == 2{
            channelValue.text = "\(originalValues[2])"
            channelnumber = originalValues[2]
        }
        else if sender.selectedSegmentIndex == 3{
            channelValue.text = "\(originalValues[3])"
            channelnumber = originalValues[3]
        }
    }
    
    
    
    @IBAction func channelButtons(_ sender: UIButton) {
        
        guard let digit = Int(sender.titleLabel!.text!)else {return}
                let digitText = sender.titleLabel?.text
                if isFirst {
                    firstNumber = digit
                    isFirst = false
                }
                else {
                    secondNumber = digit
                    calulationChannel()
                    if channelnumber > 0 {
                       // tempChanDisplay.text = ""
                        isFirst = true
                        favouriteChannel.selectedSegmentIndex = -1
                    }
                    isFirst = true
                }
    
        
    }
    
    @IBAction func channelModification(_ sender: UIButton) {
                      
        if sender.titleLabel!.text! == "CH+" {
            if channelnumber == 99 {
                channelnumber = 1
                if channelnumber < 10 {
                    channelValue.text = "0\(channelnumber)"
                }else {
                    channelValue.text = "\(channelnumber)"
                }
                
            } else {
                channelnumber += 1
                
                if channelnumber < 10 {
                    channelValue.text = "0\(channelnumber)"
                }else {
                    channelValue.text = "\(channelnumber)"
                }            }
        } else if sender.titleLabel!.text! == "CH-"{
            if channelnumber == 1 {
                channelnumber = 99
                if channelnumber < 10 {
                    channelValue.text = "0\(channelnumber)"
                }else {
                    channelValue.text = "\(channelnumber)"
                }
            } else {
                channelnumber -= 1
                if channelnumber < 10 {
                    channelValue.text = "0\(channelnumber)"
                }else {
                    channelValue.text = "\(channelnumber)"
                }
            }
        }
        
    }
    
    func calulationChannel() {
            if firstNumber == 0 {
                channelnumber = (firstNumber * 10) + secondNumber
                channelValue.text = "0\(channelnumber)"
            }
            else {
                channelnumber = (firstNumber * 10) + secondNumber
                channelValue.text = "\(channelnumber)"
            }
        }
    
    
    
    
    
}

