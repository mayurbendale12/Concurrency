//
//  PrintNumbersOperation.swift
//  Concurrency
//
//  Created by Mayur Bendale on 24/12/23.
//

import Foundation

class PrintNumbersOperation: AsyncOperation {
    var range: Range<Int>

    init(range: Range<Int>) {
        self.range = range
    }

    override func main() {
        DispatchQueue.global().async { [weak self] in
            guard let self: PrintNumbersOperation = self else { return }
            for i in self.range {
                print(i)
            }
            self.state = .isFinished
        }
    }
}
