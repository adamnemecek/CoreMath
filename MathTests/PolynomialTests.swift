//
//  PolynomialTests.swift
//  Math
//
//  Created by Paul Kraft on 28.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import XCTest
import Math

class PolynomialTests: XCTestCase {
	// MID_PRIO
	
	func testDescription() {
		for i in 1 ..< 100 {
			let a = Polynomial<Double>(integerLiteral: i)
			XCTAssert(a.description == i.description)
		}
	}
	
	func testSubscript() {
		for i in 1 ..< 30 {
			var array = [Int]()
			for _ in 0 ..< i {
				array.append(random())
			}
			let p = Polynomial(array)
			for j in 0 ..< i {
				XCTAssert(p[j] == array[j])
			}
			var q = Polynomial<Int>()
			for j in Set(0..<i) {
				q[j] = array[j]
			}
			XCTAssert(q == p)
		}
	}
	
	func testReduced() {
		var q = Polynomial<Int>()
		q[10] = 0
		XCTAssert(q.coefficients.count == 11)
		q.reduce()
		XCTAssert(q.coefficients.count == 1)
	}
	
	func testLaTeX() {
		var equals = false
		var greater = false
		var less = false
		while !equals || !greater || !less {
			let a = random() & 0xFF + 0xF
			let b = random() & 0xFF + 0xF
			let c = random() & 0xFF + 0xF
			let d = random() & 0xFF + 0xF
			let latex = Polynomial<Int>((a,b), (c,d)).latex
			if b == d {
				equals = true
				print("equals")
				XCTAssert(latex == "\(a + c)x^{\(b)}", latex)
			} else if b > d {
				greater = true
				print("greater")
				XCTAssert(latex == "\(a)x^{\(b)} + \(c)x^{\(d)}", latex)
			} else {
				less = true
				print("less")
				XCTAssert(latex == "\(c)x^{\(d)} + \(a)x^{\(b)}", latex)
			}
		}
		for i in 0 ..< 10 {
			XCTAssert(Polynomial<Int>(integerLiteral: i).latex == i.description)
		}
	}
	
	func testFactors() {
		
	}
	
}
