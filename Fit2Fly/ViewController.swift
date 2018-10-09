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

// Background function https://stackoverflow.com/questions/27049937/how-to-set-a-background-image-in-xcode-using-swift
    func assignbackground(){
        let background = UIImage(named: "background4")

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    
    
    
    //drag-in of button
    @IBOutlet weak var mainButton: UIButton!
    
    //Defining load view:
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground() //Assign background function
        
        let borderAlpha : CGFloat = 0.7
        let backgroundAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = mainButton.frame.height / 4
        
        mainButton.frame = CGRect(x: 100, y: 100,  width: 200, height: 40)
        mainButton.setTitle("Calculate", for: UIControlState.normal)
        mainButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        mainButton.backgroundColor = UIColor(white: 0.5, alpha: backgroundAlpha)
        mainButton.layer.borderWidth = 1.0
        mainButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        mainButton.layer.cornerRadius = cornerRadius
    }
    
    
// Here we define an emptry list which we can fill the points into later (they are coordinates or nothing - what the "?" means)
    var points: [Coordinate]?
    

// The button "calculate" is created on the main.storyboard and dragged to this view controller by ctrl+click. Everything underneath the button is what happens when the button is pressed. "let" is the same as variable ("var") except it cannot be changed (other languages call this a constant). These constansts are being set to the text that is inputted in the user TextFields in the UI. the "?? 0" that follows means that if there is no input the field should be put equal to 0
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
    
    //creating a function for UI alerts to the user
    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"OK",style:UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // This override function is here because when we click the button 'Calculate' the segue (the magical line between the UI views) is called and it calls this "prepare" override function first. If the next destination is the PolygonController then do the following: points becomes points in the polygonController (it is sent there from here)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let polygonController = segue.destination as? PolygonController{
            polygonController.points = points
    
    //When the calculate button is pressed and the seague is prepared the program check several if-statements below and displays alerts if the user has not met the requirements. The function for creating alerts are created earlier on this page
            
        //Checking that there are pilots
        if pilotsTextField.text?.isEmpty ?? true || (Int(pilotsTextField.text!)!) == 0 {
            createAlert(title: "You must have pilots", message: "Enter weight of pilots")
            }
            
        //Checking that the pilots weigh enough
            if let pilotsValue = Int(pilotsTextField.text ?? "") {
                if pilotsValue < 100 {
                    createAlert(title: "Pilot error", message: "Your pilot(s) weigh less than 100 LBS or 45 kg")
                    }
                }
            
            
            
            
        //Checking that there are fuel
        if fuelTextField.text?.isEmpty ?? true || (Int(fuelTextField.text!)!) == 0  {
            createAlert(title: "No fuel", message: "Enter fuel to proceed")
            }
            
        //Checking that the user is planning on using fuel
        if estimateFuelTextField.text?.isEmpty ?? true || (Int(estimateFuelTextField.text!)!) == 0 {
            createAlert(title: "No estimated fuel usage", message: "Enter estimated fuel to contuinue")
            }
            
        //Checking that there is extra fuel
        if estimateFuelTextField.text == fuelTextField.text {
            createAlert(title: "Too little fuel!", message: "Your must have more fuel than you estimate that you will use")
            }
    
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    

}


