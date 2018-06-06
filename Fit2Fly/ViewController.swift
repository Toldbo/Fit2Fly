//
//  ViewController.swift
//  Fit2Fly
//
//  Created by Christina Toldbo on 10/12/2017.
//  Copyright © 2017 Christina Toldbo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // These are the text fields you can write in (they are dragged in from the main.storyboard by holding ctrl and mouseclick)
    @IBOutlet weak var pilotsTextField: UITextField!
    @IBOutlet weak var pax1TextField: UITextField!
    @IBOutlet weak var pax2TextField: UITextField!
    @IBOutlet weak var baggageTextField: UITextField!
    @IBOutlet weak var fuelTextField: UITextField!
    @IBOutlet weak var estimateFuelTextField: UITextField!
    @IBOutlet weak var output1: UITextField!
    @IBOutlet weak var output2: UITextField!
    @IBOutlet weak var output3: UITextField!
    
    //Defining an emptry variable outside the calculate button so that it is available for the override function further down. We are just telling it that there will be points or nothing (the "?" means " or nothing")
    var points: Points?

    // "?? 0" means that if there is nothing put it equal to 0
    @IBAction func calculateButton(_ sender: UIButton) {
       let pilots = Float64(pilotsTextField.text!) ?? 0
       let pax1 = Float64(pax1TextField.text!) ?? 0
       let pax2 = Float64(pax2TextField.text!) ?? 0
       let baggage = Float64(baggageTextField.text!) ?? 0
       let fuel = Float64(fuelTextField.text!) ?? 0
       let estimateFuel = Float64(estimateFuelTextField.text!) ?? 0
        
    
        
        let pilotMomentum = bratavia.pilotsMoment(pilots: pilots)
        let pax1Momentum = bratavia.pax1Moment(pax1: pax1)
        let pax2Momentum = bratavia.pax2Moment(pax2: pax2)
        let fuelMomentum = bratavia.fuelMoment(fuelWeight: fuel)
        let baggageMomentum = bratavia.baggageMoment(baggageWeight: baggage)
        let estimateFuelMomentum = bratavia.fuelMoment(fuelWeight: estimateFuel)

        //Determining the three points to be plotted:
        let point1 = Coordinate(x: ceil(bratavia.planeWeight + pilots + pax1 + pax2 + baggage),y: ceil(bratavia.planeMomentum + pilotMomentum + pax1Momentum + pax2Momentum + baggageMomentum))
        let point2 = Coordinate(x: ceil(bratavia.planeWeight + pilots + pax1 + pax2 + baggage + fuel), y: ceil(bratavia.planeMomentum + pilotMomentum + pax1Momentum + pax2Momentum + baggageMomentum + fuelMomentum))
        let point3 = Coordinate(x: ceil(bratavia.planeWeight + pilots + pax1 + pax2 + baggage + fuel - estimateFuel), y: ceil(bratavia.planeMomentum + pilotMomentum + pax1Momentum + pax2Momentum + baggageMomentum + fuelMomentum - estimateFuelMomentum))
        
        //Providing an output so we are able to see the coordinates
        output1.text = String(point1.x)+","+String(point1.y)
        output2.text = String(point2.x)+","+String(point2.y)
        output3.text = String(point3.x)+","+String(point3.y)
        
        //grouping the three points together
        points = Points(point1:point1,point2:point2,point3:point3)
        
    }
    
    // This override function is here because when we click the button 'Graph' the segue (the magical line between the UI views) is called and it calls this "prepare" override function first. If the next destination is the PolygonController then do...
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let polygonController = segue.destination as? PolygonController{
            polygonController.points = points
        }
    }
    
}


