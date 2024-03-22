//
//  DVRViewController.swift
//  HW4
//
//  Created by CDMStudent on 2/19/24.
//

import UIKit

class DVRViewController: UIViewController {
    var currentState: DVRState = .Stopped
    var selectedButton: DVRButton = .Stop
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DVRPower.accessibilityIdentifier = "DVR_Power_Value"
        DVRStatus.accessibilityIdentifier = "DVR_State_Value"
        powerSwitch.accessibilityIdentifier = "DVR_Power_Switch"
      
        DVRPower.text = "Off"
        DVRStatus.text = "Stopped"
        dvdPowerOff()
        
    }
 
    
    @IBOutlet weak var AllButtonView: UIView!
    
    
    @IBOutlet weak var powerSwitch: UISwitch!
    @IBOutlet weak var DVRPower: UILabel!
    
    @IBOutlet weak var DVRStatus: UILabel!
    
    @IBAction func DVRSwitch(_ sender: UISwitch) {
        DVRPower.text = (sender.isOn ? "On" : "Off")
        powerSwitch.setOn(sender.isOn, animated: true)
        sender.isOn ? dvdPowerOn() : dvdPowerOff()
    }
    
    
    @IBOutlet var AllButtons: [UIButton]!
    
    
    
    @IBAction func dismissDVRViewController(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true)
    }
    
    func dvdPowerOff(){
        //AllButtonView.isUserInteractionEnabled = false
       
        for case let button as UIButton in AllButtons {
            button.isEnabled = false
            
        }}
        func dvdPowerOn(){
            //AllButtonView.isUserInteractionEnabled = true
       
            for case let button as UIButton in AllButtons {
                button.isEnabled = true
                
            }
        }
    @IBAction func playButtonClicked(_ sender: UIButton) {
        buttonOperation(state: currentState, button: .Play)
        
    }
    
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        buttonOperation(state: currentState, button: .Stop)
    }
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        buttonOperation(state: currentState, button: .Pause)
    }
    
    
    @IBAction func fastforwardButton(_ sender: UIButton) {
        buttonOperation(state: currentState, button:.FF)
    }
   
    
    @IBAction func fastrewindButtonPressed(_ sender: UIButton) {
        buttonOperation(state: currentState, button:.FR)
    }
   
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        buttonOperation(state: currentState, button:.Record)
    }
    
    
    func InvalidOperation(state : DVRState ){
        let title = "Invalid Operation"
        let message = "Cannot (Play, Pause, Fast Forward, Fast Rewind, Record,Stop) while (Current operation: Paused, Fast Forwarding, Fast Rewinding,Recording, Stopped)"
        let alertController =
            UIAlertController(title: title,
                              message: message,
                              preferredStyle: .actionSheet)
        
        // Create the action.
        let forceAction = UIAlertAction(title:"Force", style: .default ){ _ in
            
            self.forceOperation( state: state)
        }
        alertController.addAction(forceAction)
        let cancelAction =
            UIAlertAction(title: "Cancel",
                          style: .cancel,
                          handler: nil)
        alertController.addAction(cancelAction)
        present(alertController,
                animated: true,
                completion: nil)
        
    }
    func forceOperation(state : DVRState) {
    
        currentState = state
        DVRStatus.text = currentState.rawValue
        let title = "Force Operation"
        let message = "(Forced Operation: Play, Pause, Fast Forward, Fast Rewind,Record, Stop) operation succeeded"
        let alertController =
            UIAlertController(title: title,
                              message: message,
                              preferredStyle: .alert)
        
        // Create the action.
        let cancelAction =
            UIAlertAction(title: "Ok",
                          style: .cancel,
                          handler: nil)
        alertController.addAction(cancelAction)
        present(alertController,
                animated: true,
                completion: nil)
        
    }
    
    enum DVRState : String {
            case Stopped = "Stopped"
            case Playing = "Playing"
            case FastForward = "Fast Forwarding"
            case FastRewind = "Fast Rewinding"
            case Recording = "Recording"
            case Paused = "Paused"
        var name : String { return self.rawValue }
    }
    enum DVRButton {
            case Stop
            case Play
            case Pause
            case FF
            case FR
            case Record
    }
    
    func buttonOperation( state: DVRState, button : DVRButton){
        switch(state,button){
        case(_,.Stop):
            DVRStatus.text = DVRState.Stopped.rawValue
            currentState = .Stopped
        case(_,.Play):
            DVRStatus.text = DVRState.Playing.rawValue
            currentState = .Playing
        case (.Playing,.Pause):
            DVRStatus.text = DVRState.Paused.rawValue
            currentState = .Paused
        case (_,.Pause):
            InvalidOperation( state: .Paused)
        case (.Playing,.FF):
            DVRStatus.text = DVRState.FastForward.rawValue
            currentState = .FastForward
        case (_,.FF):
            InvalidOperation( state: .FastForward)
        case (.Playing,.FR):
            DVRStatus.text = DVRState.FastRewind.rawValue
            currentState = .FastRewind
        case (_,.FR):
            InvalidOperation( state: .FastRewind)
        case (.Stopped,.Record):
            DVRStatus.text = DVRState.Recording.rawValue
            currentState = .Recording
        case (_,.Record):
            InvalidOperation( state: .Recording)
        
        }
        
        
    }
        
}
