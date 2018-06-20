//
//  Data.swift
//  Fit2Fly
//
//  Created by Christina Toldbo on 10/12/2017.
//  Copyright © 2017 Christina Toldbo. All rights reserved.
//

import Foundation

class InputData {
    var pilots: Float64
    var pax1: Float64
    var pax2: Float64
    var fuelWeight: Float64
    var baggageWeight: Float64
    var estimateFuel: Float64

    required init(pilots:Float64,pax1:Float64,pax2:Float64,fuelWeight:Float64,baggageWeight:Float64,estimateFuel:Float64) {
        self.pilots = pilots
        self.pax1 = pax1
        self.pax2 = pax2
        self.fuelWeight = fuelWeight
        self.baggageWeight = baggageWeight
        self.estimateFuel = estimateFuel
        
    }

}
// A struct is an inventory list - (like a fancy version of a normal list, but where you know how the data will look every time) Like coordinates always has a x and a y
struct Coordinate {
    var x: Double
    var y: Double
}

struct Points {
    var point1: Coordinate
    var point2: Coordinate
    var point3: Coordinate
}

struct Interval {
    var min: Float64
    var max: Float64
}

class PlaneData {
    var planeWeight: Float64
    var planeMomentum: Float64
    
    var pilots: Interval
    var pax1: Interval
    var pax2: Interval
    var fuelWeight: Interval
    var baggageWeight: Interval
    var estimateFuel: Interval
    
    var pilotsSlope: Float64
    var pax1Slope: Float64
    var pax2Slope: Float64
    var fuelSlope: Float64
    var baggageSlope: Float64
    
    var polygon:[Coordinate]
    
    
    required init(
        planeWeight:Float64,
        planeMomentum: Float64,
        pilots:Interval,
        pax1:Interval,
        pax2:Interval,
        fuelWeight:Interval,
        baggageWeight:Interval,
        estimateFuel:Interval,
        pilotsSlope:Float64,
        pax1Slope:Float64,
        pax2Slope:Float64,
        fuelSlope:Float64,
        baggageSlope:Float64,
        polygon:[Coordinate]) {
        self.planeWeight = planeWeight
        self.planeMomentum = planeMomentum
        self.pilots = pilots
        self.pax1 = pax1
        self.pax2 = pax2
        self.fuelWeight = fuelWeight
        self.baggageWeight = baggageWeight
        self.estimateFuel = estimateFuel
        self.pilotsSlope = pilotsSlope
        self.pax1Slope = pax1Slope
        self.pax2Slope = pax2Slope
        self.fuelSlope = fuelSlope
        self.baggageSlope = baggageSlope
        self.polygon = polygon
    }
    
    func pilotsMoment(pilots:Float64) -> Float64 {
        return pilots/self.pilotsSlope
    }
    func pax1Moment(pax1:Float64) -> Float64 {
        return pax1/self.pax1Slope
    }
    func pax2Moment(pax2:Float64) -> Float64 {
        return pax2/self.pax2Slope
    }
    func fuelMoment(fuelWeight:Float64) -> Float64 {
        return fuelWeight/self.fuelSlope
    }
    func baggageMoment(baggageWeight:Float64) -> Float64 {
        return baggageWeight/self.baggageSlope
    }
}

// Calculated in LBS
var bratavia = PlaneData(
    planeWeight: 2858,
    planeMomentum: 48000,
    pilots: Interval(min:80,max:400),
    pax1: Interval(min:0,max:400),
    pax2: Interval(min:0,max:400),
    fuelWeight: Interval(min:0,max:280),
    baggageWeight: Interval(min:0,max:120),
    estimateFuel: Interval(min:0,max:280),
    //Slopes are calculated from the slopes in the Flight Manual Section 6, figure 6-4 (R.A.I. Approval No. 148015/T
    pilotsSlope: -0.026,
    pax1Slope: -0.136,
    pax2Slope: 0.029,
    fuelSlope: 0.033,
    baggageSlope: 0.016,
    polygon:[
        Coordinate(x:27500,y:2650),
        Coordinate(x:39500,y:3540),
        Coordinate(x:57500,y:4320),
        Coordinate(x:89000,y:4320),
        Coordinate(x:55000,y:2640)]
)






