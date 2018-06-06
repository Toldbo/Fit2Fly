//
//  PolygonController.swift
//  Fit2Fly
//
//  Created by Christina Toldbo on 10/12/2017.
//  Copyright © 2017 Christina Toldbo. All rights reserved.
//

import UIKit
import Charts

class PolygonController: UIViewController {
  
    // Defining the variable points in this Polygon controller (they are going to be sent from ViewController) and they will be points or nothing (which is what the ? means) - they only exist if you click "Calculate"
    var points : Points?
    
 //Drawn in from Polygon controller
    @IBOutlet weak var polygon: LineChartView!

    
//The following two override functions come automatically with the creation of the ViewController (which is automatic when creating a project. We have deleted them from the view controller and placed them here because we need the calculation to happen automatically)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var coordinates : [ChartDataEntry] = []
        for coordinate in bratavia.polygon {
            coordinates.append(ChartDataEntry(x: Double(coordinate.x), y: Double(coordinate.y)))
            
        }
        let polygonSet = LineChartDataSet(values: coordinates, label: nil)
        let polygonSet2 = LineChartDataSet(values: [coordinates[0],coordinates[4],coordinates[3]], label: nil)
        
        var temp : [LineChartDataSet] = []
        
        if let points = points {
        let point1 = LineChartDataSet(values: [transformToChartDataEntry(coordinate: points.point1)], label: "point1")
        let point2 = LineChartDataSet(values: [transformToChartDataEntry(coordinate: points.point2)], label: "point2")
        let point3 = LineChartDataSet(values: [transformToChartDataEntry(coordinate: points.point3)], label: "point3")
            
            temp.append(point1)
            temp.append(point2)
            temp.append(point3)
        }
        
        let data = LineChartData(dataSets: [polygonSet, polygonSet2] + temp)
        
        polygonSet.circleRadius = 3
        polygonSet2.circleRadius = 3
        polygon.data = data
    
        // Do any additional setup after loading the view
    }
    func transformToChartDataEntry(coordinate:Coordinate) -> ChartDataEntry {
        return ChartDataEntry(x: Double(coordinate.x), y: Double(coordinate.y))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



