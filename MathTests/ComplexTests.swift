//
//  ComplexTests.swift
//  Math
//
//  Created by Paul Kraft on 29.07.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import XCTest
import Math

class ComplexTests: XCTestCase, TypeTest {
    typealias N = R
    
    override func setUp() {
        for _ in 0 ..< 30 { elements.append(C(real: N.random, imaginary: N.random)) }
    }
    
    var elements : [Complex<N>] = []
    
    // basic arithmetic
    func testAddition() {
        forAll("+", assert: { $0.real + $1.real == $2.real && $0.imaginary + $1.imaginary == $2.imaginary }) { $0 + $1 }
    }
    
    func testSubtraction() {
        forAll("-", assert: { $0.real - $1.real == $2.real && $0.imaginary - $1.imaginary == $2.imaginary }) { $0 - $1 }
    }
    
    func testMultiplication()   {
        // forAll("*", assert: { ($0.real * $1.real) + ($0.imaginary * $1.imaginary) == $2.real }) { $0 * $1 }
    }
    func testDivision()         {
        // forAll("/",   assert: { $0.real / $1.real == $2.real }) { $0 / $1 }
    }
    
    // specials
    func testConjugate()        { forAll("conj",assert: { $0.real == $1.real && $0.imaginary == -($1.imaginary) }) { $0.conjugate } }}