//
//  Test.swift
//  Math
//
//  Created by Paul Kraft on 06.05.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import XCTest

extension XCTestCase {
    func measureThrowingBlock(block: () throws -> Void) {
        measureBlock {
            nocatch(block)
        }
    }
}

func nocatch(block: () throws -> () ) {
    do {
        try block()
    } catch let e {
        print(e)
    }
}

func nocatch<T>(block: () throws -> T) -> T? {
    do {
        return try block()
    } catch let e {
        print(e)
        return nil;
    }
}