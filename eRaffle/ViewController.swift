//
//  ViewController.swift
//  eRaffle
//
//  Created by Avery  Higgins on 8/19/17.
//  Copyright © 2017 Avery  Higgins. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    @IBOutlet weak var ChosenRaffleAnnouncement: UILabel!
    
    @IBAction func ChooseButton(_ sender: Any) {
        let tick = RaffleManager.chooseTicket()
        if(tick != nil){
            output = RaffleManager.respond(ticket: tick!)
            
            ChosenRaffleAnnouncement.text = output
            ChosenRaffleAnnouncement.isHidden = false
            
            displayMessageInterface(tick: tick!)
            //sendAlert(phoneNumber: "tick?.phone")
            
        }
        
        let alertController = UIAlertController(title: "eRaffle", message:
            output, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    var output: String = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ChosenRaffleAnnouncement.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendAlert(phoneNumber: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = [phoneNumber]
            //controller.messageComposeDelegate = self
            //self.present(controller, animated: true, completion: nil)
        }
        
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            //... handle sms screen actions
            //self.dismiss(true)
        }
        
    }
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    }
    
    func displayMessageInterface(tick: Ticket) {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        
        composeVC.recipients = [tick.phone]
        let message = (String(format: "Congratulations%@! Your Raffle Ticket #&d Won!", tick.name, tick.ident))
        
        //composeVC.body = "Congratulations! Your Raffle "
        composeVC.body = message
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Can't send messages.")
        }
    }


}

