//
//  CubicSplineInterpolation.swift
//  Math
//
//  Created by Paul Kraft on 01.12.17.
//  Copyright © 2017 pauljohanneskraft. All rights reserved.
//

public struct CubicSplineInterpolation {
    public var function: DiscreteFunction
    var functionDerivative: Function
    
    public init(function: DiscreteFunction) {
        self.function = function
        self.functionDerivative = function.derivative
    }
}

extension CubicSplineInterpolation: Interpolation {
    public func call(x: Double) -> Double {
        guard let index = function.points.index(where: { $0.x >= x }) else {
            return function.points.last?.y ?? 0
        }
        guard index > 0 else { return function.points.first?.y ?? 0 }
        
        let this = points[index - 1]
        let next = points[index]
        let thisDy = functionDerivative.call(x: this.x)
        let nextDy = functionDerivative.call(x: next.x)
        
        let h = next.x - this.x
        let t = (x - this.x) / h
        
        let t2 = t * t, t3 = t2 * t
        let f1 = (2*t3 - 3*t2 + 1), f2 = (-2*t3 + 3*t2)
        let f3 = (t3 - 2*t2 + t) * h, f4 = (t3 - t2) * h
        
        return this.y * f1 + next.y * f2 + thisDy * f3 + nextDy * f4
    }
}
