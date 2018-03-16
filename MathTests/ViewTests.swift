//
//  ViewTests.swift
//  MathTests
//
//  Created by Paul Kraft on 04.12.17.
//  Copyright © 2017 pauljohanneskraft. All rights reserved.
//

import Math
import XCTest

class ViewTests: XCTestCase {
    let showWindows = false
    
    override func setUp() {
        super.setUp()
        guard showWindows else { return }
        AppDelegate.start(name: "Math")
    }
    
    override func tearDown() {
        super.tearDown()
        guard showWindows else { return }
        NSApp?.run()
    }
    
    func testSmoothWindow() {
        guard showWindows else { return }
        let function = ((Sin(x) * (x^0.01)) + (x^0.5)).sampled(start: 0, end: 50, count: 200)
        let window = function.smoothWindow(frame: CGRect(x: 10, y: 10, width: 300, height: 300))
        AppDelegate.shared?.open(window: window)
    }
    
    func testCustomInterpolationPlotWindow() {
        print("halloIchBins".splitCamelCase().lowercased() == "hallo Ich Bins".lowercased())
        guard showWindows else { return }
        let functions = InterpolationTests.functions + [Functions.sin / x, Functions.cos / x]
        let interpolations: [Interpolation.Type] = [
            CubicSplineInterpolation.self, NewtonPolynomialInterpolation.self,
            NearestNeighborInterpolation.self, LinearInterpolation.self
        ]
        let range = SamplingRange(start: -10, end: 10, count: 21)
        let frame = CGRect(origin: .zero, size: CGSize(width: 600, height: 300))
        let window = CustomInterpolationPlotView.createInterpolatingWindow(
            frame: frame, functions: functions, interpolations: interpolations, range: range)
        window.minSize = frame.size
        AppDelegate.shared?.open(window: window)
    }
    
    func testInterpolationPlots() {
        guard showWindows else { return }
        let functions = InterpolationTests.functions
        let random = Int.random(inside: 0...functions.count-1)
        print(random, functions[random])
        let function = Functions.sin / x // functions[random]
        testInterpolationPlots(function: function, using: CubicSplineInterpolation.self)
        testInterpolationPlots(function: function, using: NewtonPolynomialInterpolation.self)
        testInterpolationPlots(function: function, using: NearestNeighborInterpolation.self)
        testInterpolationPlots(function: function, using: LinearInterpolation.self)
    }
    
    func testInterpolationPlots<I: Interpolation>(function: Function, using: I.Type) {
        let range = SamplingRange(start: 0.2, end: 10, count: 12)
        let window = function.interpolatingWindow(in: range, using: using)
        AppDelegate.shared?.open(window: window)
    }
    
    func testTransformPlots() {
        guard showWindows else { return }
        let frame = CGRect(origin: .zero, size: CGSize(width: 600, height: 300))
        let range = SamplingRange(start: 0, end: 2*Double.pi, count: 10)
        let window = DiscreteFourierPlotView.createWindow(frame: frame, functions: InterpolationTests.functions,
                                                          range: range)
        window.minSize = frame.size
        AppDelegate.shared?.open(window: window)
    }
}

final class AppDelegate: NSObject, ApplicationDelegate {
    static var shared: AppDelegate?
    var windows = [NSWindow]()
}