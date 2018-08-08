//
//  ViewController.swift
//  Fit2Fly
//
//  Created by Christina Toldbo on 10/12/2017.
//  Copyright © 2017 Christina Toldbo. All rights reserved.
//

//pre-made package for everything beginning with UI. textfields, views etc. Created when making the file: ViewController and AppDelegate.
import UIKit
class ViewController: UIViewController {

// Text fields for writing in (The fields are created in the Main.storyboard and dragged in by bringing up both screens and holding ctrl and mouseclick)
    @IBOutlet weak var pilotsTextField: UITextField!
    @IBOutlet weak var pax1TextField: UITextField!
    @IBOutlet weak var pax2TextField: UITextField!
    @IBOutlet weak var baggageTextField: UITextField!
    @IBOutlet weak var fuelTextField: UITextField!
    @IBOutlet weak var estimateFuelTextField: UITextField!

    
    
    
// Here we define an emptry list which we can fill the points into later (they are coordinates or nothing - what the "?" means)
    var points: [Coordinate]?
    

// The button "calculate" is created on the main.storyboard and dragged to this view controller by ctrl+click. Everything underneath the button is what happens when the button is pressed. "let" is the same as variable ("var") except it cannot be changed (other languages call this a constant). These constansts are being set to the text that is inputted in the user TextFields in the UI. the "?? 0" that follows means that if there is no input the field should be put equal to 0
    //@IBAction func calculateButton(_ sender: UIButton) {
    
    
    @IBAction func calculateButton(_ sender: UIButton) {
       let pilots = Float64(pilotsTextField.text!) ?? 0
       let pax1 = Float64(pax1TextField.text!) ?? 0
       let pax2 = Float64(pax2TextField.text!) ?? 0
       let baggage = Float64(baggageTextField.text!) ?? 0
       let fuel = Float64(fuelTextField.text!) ?? 0
       let estimateFuel = Float64(estimateFuelTextField.text!) ?? 0


// Calculating the momentum of each input. It uses the function defined in Data.swift and sends in for example Pilots.slope specifically for bratavia plane type (by adding bratavia in front)
        let pilotMomentum = bratavia.pilotsMoment(pilots: pilots)
        let pax1Momentum = bratavia.pax1Moment(pax1: pax1)
        let pax2Momentum = bratavia.pax2Moment(pax2: pax2)
        let fuelMomentum = bratavia.fuelMoment(fuelWeight: fuel)
        let baggageMomentum = bratavia.baggageMoment(baggageWeight: baggage)
        let estimateFuelMomentum = bratavia.fuelMoment(fuelWeight: estimateFuel)

        //Determining the three points to be plotted:
        let point1 = Coordinate(x: ceil(bratavia.planeMomentum + pilotMomentum + pax1Momentum + pax2Momentum + baggageMomentum), y: ceil(bratavia.planeWeight + pilots + pax1 + pax2 + baggage))
        let point2 = Coordinate(x: ceil(bratavia.planeMomentum + pilotMomentum + pax1Momentum + pax2Momentum + baggageMomentum + fuelMomentum), y: ceil(bratavia.planeWeight + pilots + pax1 + pax2 + baggage + fuel))
        let point3 = Coordinate(x: ceil(bratavia.planeMomentum + pilotMomentum + pax1Momentum + pax2Momentum + baggageMomentum + fuelMomentum - estimateFuelMomentum), y: ceil(bratavia.planeWeight + pilots + pax1 + pax2 + baggage + fuel - estimateFuel))
        
        //for debugging. Providing an output so we are able to see the coordinates:
        print("point1: \(point1)")
        print("point2: \(point2)")
        print("point3: \(point3)")
        
        
        //grouping the three points together
        points = [point1, point2, point3]
        
    }
    
    // This override function is here because when we click the button 'Calculate' the segue (the magical line between the UI views) is called and it calls this "prepare" override function first. If the next destination is the PolygonController then do the following: points becomes points in the polygonController (it is sent there from here)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let polygonController = segue.destination as? PolygonController{
            polygonController.points = points
            
    
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    

}


