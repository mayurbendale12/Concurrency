//
//  ActorViewController.swift
//  Concurrency
//
//  Created by Mayur Bendale on 24/12/23.
//

import UIKit

class ActorViewController: UIViewController {
    @IBOutlet private weak var seatLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Even we book seat, it shows in available seats
        // This can be fix by instroducing barrorQueue in Flight Model where availableSeats is shared resources access by two threads, one thread is writing and one thread is reading
        
//        createDataRaceWhichLeadsDataInconsistency()

//        solveDataRaceUsingActors()
    }

    private func createDataRaceWhichLeadsDataInconsistency() {
        let queue1 = DispatchQueue(label: "queue1")
        let queue2 = DispatchQueue(label: "queue2")

        let flight = Flight()

        queue1.async {
            let bookedSeat = flight.bookSeat()
            print("Booked seat is \(bookedSeat)")
        }

        queue2.async {
            let availableSeats = flight.getAvailableSeats()
            print("Available seats \(availableSeats)")
        }
    }

    private func solveDataRaceUsingActors() {
        let queue1 = DispatchQueue(label: "queue1")
        let queue2 = DispatchQueue(label: "queue2")

        let flight = FlightActor()

        queue1.async {
            Task {
                let bookedSeat = await flight.bookSeat()
                print("Booked seat is \(bookedSeat)")
                self.updateSeat(seat: bookedSeat)
            }
        }

        queue2.async {
            Task {
                let availableSeats = await flight.getAvailableSeats()
                print("Available seats \(availableSeats)")
            }
        }
    }

    //MainActor: This is introduced newly which moves the context on main thread we don't have to use DispatchQueue.asyn.main to update UI on main thread. By using MainActor we can safely call this function from background thread or asynchronous block of code.
    @MainActor
    private func updateSeat(seat: String) {
        seatLabel.text = seat
    }
}
