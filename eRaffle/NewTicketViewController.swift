//
//  NewTicketViewController.swift
//  eRaffle
//
//  Created by Avery  Higgins on 8/19/17.
//  Copyright © 2017 Avery  Higgins. All rights reserved.
//

import UIKit

class NewTicketViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var raffleNumberLabel: UILabel!
    
    @IBOutlet weak var numberOfTicketsText: UITextField!
    
    @IBOutlet weak var numOfTicketsStepperValue: UIStepper!
    
    @IBAction func numberOfTicketsStepper(_ sender: UIStepper) {
        
        
            numberOfTicketsText.text = String(numOfTicketsStepperValue.value)
            numOfTix = Int(numOfTicketsStepperValue.value)
        
        
        
        
    }
    
    
    @IBAction func recieveTicketButton(_ sender: UIButton) {
        
        let random = Int(arc4random_uniform(10000))
        
        raffleNum = random
        
        raffleNumberLabel.text = String(random)
        
        raffleNumberLabel.isHidden = false
        doneButton.isEnabled = true
        doneButton.isHidden = false
        
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        for _ in 0...numOfTix - 1{
            load()
        }
        
        
        
    }
    
    @IBOutlet weak var doneButton: UIButton!
    
    var name: String?
    var phone: String?
    var raffleNum: Int?
    var numOfTix: Int = 0
    
    
    func load() {
        
        name = nameTextField.text
        phone = phoneTextField.text!
        let ticket = Ticket(ident: raffleNum!, name: name!, phone: phone!)
        if((name?.utf8CString.count)! > 0 && (phone?.utf8CString.count)! > 0){
            RaffleManager.addTicket(ticket: ticket)
            print(RaffleManager.tickets)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        doneButton.isHidden = true
        doneButton.isEnabled = false
        
        raffleNumberLabel.isHidden = true
        
        self.nameTextField.delegate = self
        self.phoneTextField.delegate = self
        self.numberOfTicketsText.delegate = self
        numberOfTicketsText.text = "1"
        numOfTix = 1
        // Do any additional setup after loading the view.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
