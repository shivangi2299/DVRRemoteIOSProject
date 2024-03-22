//
//  ConfigViewController.swift
//  HW4
//
//  Created by CDMStudent on 2/25/24.
//

import UIKit

class ConfigViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        channelChanger.value = 1
        channelChanger.minimumValue = 1
        channelChanger.maximumValue = 99
        

        changedChannel.accessibilityIdentifier = "Channel_Label_Value"
        textField.accessibilityIdentifier = "Label_TextField_Value"
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var ControlFavourites: UISegmentedControl!
    
    @IBOutlet weak var channelChanger: UIStepper!
    
    @IBOutlet weak var changedChannel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, 
//                   replacementString string: String) -> Bool {
//        return  ((textField.text?.count ?? 0) + string.count) <= 4
//    }
    
    
    
    @IBAction func steppperFunction(_ sender: UIStepper) {
        changedChannel.text = "\(Int(sender.value))"

    }
        
    @IBAction func cancelBut(_ sender: UIButton) {
        changedChannel.text = "1"
        channelChanger.value = 1
        textField.text = nil
        
    }
    
    
    
    
    @IBAction func didEditEnds(_ sender: UITextField){
        sender.resignFirstResponder()
    }
    
    @IBAction func saveDetails(_ sender: UIButton) {
    guard let text = textField.text, (1...4).contains(text.count) else {
            let title = "Invalid label length"
            let message = "Label must be between 1-4 characters long."
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
            return
        }
        DataModel.shared.segment = ControlFavourites.selectedSegmentIndex
        DataModel.shared.text = textField.text!
        DataModel.shared.ChanNo = Int(changedChannel.text!)!
        
    }
    
}
