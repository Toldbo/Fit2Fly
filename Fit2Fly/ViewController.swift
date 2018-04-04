//
//  ViewController.swift
//  Fit2Fly
//
//  Created by Christina Toldbo on 10/12/2017.
//  Copyright © 2017 Christina Toldbo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pilotsTextField: UITextField!
    @IBOutlet weak var pax1TextField: UITextField!
    @IBOutlet weak var pax2TextField: UITextField!
    @IBOutlet weak var baggageTextField: UITextField!
    @IBOutlet weak var fuelTextField: UITextField!
    @IBOutlet weak var estimateFuelTextField: UITextField!
    @IBOutlet weak var output1: UITextField!
    @IBOutlet weak var output2: UITextField!
    @IBOutlet weak var output3: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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

       output1.text = String(ceil(bratavia.planeWeight + pilots + pax1 + pax2 + baggage))+","+String(ceil(bratavia.planeMomentum + pilotMomentum + pax1Momentum + pax2Momentum + baggageMomentum))
       output2.text = String(ceil(bratavia.planeWeight + pilots + pax1 + pax2 + baggage + fuel))+","+String(ceil(bratavia.planeMomentum + pilotMomentum + pax1Momentum + pax2Momentum + baggageMomentum + fuelMomentum))
       output3.text = String(ceil(bratavia.planeWeight + pilots + pax1 + pax2 + baggage + fuel - estimateFuel))+","+String(ceil(bratavia.planeMomentum + pilotMomentum + pax1Momentum + pax2Momentum + baggageMomentum + fuelMomentum - estimateFuelMomentum))
    }
    
}


