//
//  CustomOperation.swift
//  Concurrency
//
//  Created by Mayur Bendale on 24/12/23.
//

import Foundation

class CustomOperation: Operation {
    override func main() {
        for i in 0 ... 10 {
            print(i)
        }
    }
}
