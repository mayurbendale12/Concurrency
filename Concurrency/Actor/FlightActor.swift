//
//  FlightActor.swift
//  Concurrency
//
//  Created by Mayur Bendale on 24/12/23.
//

import Foundation

actor FlightActor {
    private nonisolated var company: String {
        return "Vistara"
    }

    private var availableSeats: [String] = ["1A", "1B", "1C"]

    func getAvailableSeats() -> [String] {
        return availableSeats
    }

    func bookSeat() -> String {
        let bookedSeat = availableSeats.first ?? ""
        availableSeats.removeFirst()
        return bookedSeat
    }
}
