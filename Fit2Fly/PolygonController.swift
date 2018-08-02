//
//  PolygonController.swift
//  Fit2Fly
//
//  Created by Christina Toldbo on 10/12/2017.
//  Copyright © 2017 Christina Toldbo. All rights reserved.
//

import UIKit

// Charts is from https://github.com/danielgindi/Charts/blob/master/README.md
import Charts


class PolygonController: UIViewController {
    
    // Defining the variable points in this Polygon controller (they are going to be sent from ViewController) and they will be points or nothing (which is what the ? means) - they only exist if you click "Calculate"
    var points : Points?
    
    //Dragged in from Polygon controller
    @IBOutlet weak var chart: LineChartView!
    
    
    //The following two override functions come automatically with the creation of the ViewController (which is automatic when creating a project. We have deleted them from the view controller and placed them here because we need the calculation to happen automatically)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chart.dragEnabled = true
        chart.setScaleEnabled(true)
        chart.pinchZoomEnabled = true
        
        
        //DRAWING THE POLYGON
        // Creating the polygon by creating an empty list called polygonBoundaries. The for loop runs though the coordinates specified in the bratavia variable in the Data.swift file and fills in the empty list by appending the polygon "corners" (5 coordinates) to the list
        var polygonBoundaries : [ChartDataEntry] = []
        for polygonBoundary in bratavia.polygon {
            polygonBoundaries.append(ChartDataEntry(x: Double(polygonBoundary.x), y: Double(polygonBoundary.y)))
            
        }
        
        // We have to create the polygon by making two data sets (otherwise we are apparently not allowed to give two y values to the same x value in a line chart. The polygonSet has all the corners (but does not plot the last, while polygonSet2 has only the first, and the two last (hence the whole polygon is drawn)
        let polygonSet = LineChartDataSet(values: polygonBoundaries, label: nil)
        let polygonSet2 = LineChartDataSet(values: [polygonBoundaries[0],polygonBoundaries[4],polygonBoundaries[3]], label: nil)
        polygonSet.setCircleColor(.black)
        polygonSet2.setCircleColor(.black)
        polygonSet.circleRadius = 1
        polygonSet.setColor(.black)
        polygonSet2.circleRadius = 1
        
        
        //DRAWING THE 3 COORDINATES
        //creating an empty list for the points to be rendered. The "if let" means that "If the points excist" then do the thing within the block. If we did not do it like this then if there were no points then the whole application would crash whereas now we have the possibility to write a catch.
        var pointsRendered : [LineChartDataSet] = []
        
        if let points = points {
            let point1 = LineChartDataSet(values: [transformToChartDataEntry(coordinate: points.point1)], label: "Zero Fuel")
            let point2 = LineChartDataSet(values: [transformToChartDataEntry(coordinate: points.point2)], label: "Take off")
            let point3 = LineChartDataSet(values: [transformToChartDataEntry(coordinate: points.point3)], label: "landing")
            
            
            // color of labels (setColor), color of point (setCircleColor), and size of point
            point1.setColor(.blue)
            point1.setCircleColor(.blue)
            point1.circleRadius = 4
            
            
            point2.setColor(.red)
            point2.setCircleColor(.red)
            point2.circleRadius = 4
            
            point3.setColor(.green)
            point3.setCircleColor(.green)
            point3.circleRadius = 4
            
            pointsRendered.append(point1)
            pointsRendered.append(point2)
            pointsRendered.append(point3)
        }
        
        //combining polygon and points to be rendered in one variable
        let chartRedered = LineChartData(dataSets: [polygonSet, polygonSet2] + pointsRendered)
        chart.data = chartRedered
        
        
        
        
        // This function
    }
    func transformToChartDataEntry(coordinate:Coordinate) -> ChartDataEntry {
        let data = ChartDataEntry(x: Double(coordinate.x), y: Double(coordinate.y))
        return data
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




