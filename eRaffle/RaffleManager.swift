//
//  RaffleManager.swift
//  eRaffle
//
//  Created by Avery  Higgins on 8/19/17.
//  Copyright © 2017 Avery  Higgins. All rights reserved.
//
import MessageUI

import Foundation

class RaffleManager {
   static var tickets : [Ticket] = []

static func addTicket(ticket: Ticket){
    var b = ticket
    
    for ticket2 in tickets{
        if(ticket2.ident == ticket.ident){
            b = Ticket(ident: ticket.ident + 1, name: ticket.name, phone: ticket.phone)
        }
    
    }
    
    
    
    tickets.append(b)
    printTickets()
}
    
    static func printTickets() {
    
        for ticket in tickets{
            
        print(ticket.name)
        
        }
    
    
    }

static func chooseTicket() -> Ticket?{

    if(tickets.count > 0){
    
    let randomTicket = Int(arc4random_uniform(UInt32(tickets.count)))

        return tickets[randomTicket]
    }
    else{
        return nil
    }
    
}

static func respond(ticket: Ticket) -> String{

    return(ticket.name + " won the raffle with the number " + String(ticket.ident) + "!")
    
    }
    

    
}


