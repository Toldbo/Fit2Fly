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


// The class PolygonController has been created when we made this viewcontroller (and inherrit the class UIViewController automatically). Later we have added the "UITableViewDataSource" and "UITableViewDelegate" to create a table.
class PolygonController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    
//PREPARING THE CHART
    // Defining the variable points in this Polygon controller (they are going to be sent from ViewController) and they will be points or nothing (which is what the ? means) - they only exist if you click "Calculate"
    var points : [Coordinate]?
    
    //Dragged in from Polygon controller (this is the "field" where the polygon is eventually rendered.
    @IBOutlet weak var chart: LineChartView!
    
    
    //The following two override functions come automatically with the creation of the ViewController (which is automatic when creating a project. We have deleted them from the view controller and placed them here because we need the calculation to happen automatically)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chart.chartDescription?.enabled = false //removes a small description in the corner
        self.chart.legend.enabled = false //removes all labels so we can make them again.
        
        
    func transformToChartDataEntry(coordinate:Coordinate) -> ChartDataEntry {
        let data = ChartDataEntry(x: Double(coordinate.x), y: Double(coordinate.y))
        return data
        }
        
        
//DRAWING THE POLYGON
        // Creating the polygon by creating an empty list called polygonBoundaries. The for loop runs though the coordinates specified in the bratavia variable in the Data.swift file and fills in the empty list by appending the polygon "corners" (5 coordinates) to the list
        var polygonBoundaries : [ChartDataEntry] = []
        for polygonBoundary in bratavia.polygon {
            polygonBoundaries.append(ChartDataEntry(x: Double(polygonBoundary.x), y: Double(polygonBoundary.y)))
            
        }
        
        // We have to create the polygon by making two data sets (otherwise we are apparently not allowed to give two y values to the same x value in a line chart. The polygonSet has all the corners (but does not plot the last, while polygonSet2 has only the first, and the two last (hence the whole polygon is drawn)
        let polygonSet = LineChartDataSet(values: [polygonBoundaries[0],polygonBoundaries[1],polygonBoundaries[2],polygonBoundaries[3]], label: nil)
        let polygonSet2 = LineChartDataSet(values: [polygonBoundaries[0],polygonBoundaries[4],polygonBoundaries[3]], label: nil)
        let polygonSet3 = LineChartDataSet(values: [polygonBoundaries[5],polygonBoundaries[6]], label: nil)
        
        polygonSet.setCircleColor(.black)
        polygonSet.setColor(.black)
        polygonSet.circleRadius = 1
        polygonSet.drawValuesEnabled = false
        
        polygonSet2.setCircleColor(.black)
        polygonSet2.setColor(.black)
        polygonSet2.circleRadius = 1
        polygonSet2.drawValuesEnabled = false
        
        polygonSet3.setCircleColor(.green)
        polygonSet3.setColor(.green)
        polygonSet3.circleRadius = 1
        polygonSet3.drawValuesEnabled = false
        
        
//DRAWING THE 3 COORDINATES
        //creating an empty list for the points to be rendered. The "if let" means that "If the points excist" then do the thing within the block. If we did not do it like this then if there were no points then the whole application would crash whereas now we have the possibility to write a catch.
        var pointsRendered : [LineChartDataSet] = []
        
        if let points = points {
            let point1 = LineChartDataSet(values: [transformToChartDataEntry(coordinate: points[0])], label: "Zero fuel")
            let point2 = LineChartDataSet(values: [transformToChartDataEntry(coordinate: points[1])], label: "Takeoff")
            let point3 = LineChartDataSet(values: [transformToChartDataEntry(coordinate: points[2])], label: "Landing")
            
            
            // color of labels (setColor), color of point (setCircleColor), and size of point
            point1.setColor(.blue)
            point1.setCircleColor(.blue)
            point1.circleRadius = 4
            point1.drawValuesEnabled = false
            
            
            point2.setColor(.red)
            point2.setCircleColor(.red)
            point2.circleRadius = 4
            point2.drawValuesEnabled = false
            
            point3.setColor(.green)
            point3.setCircleColor(.green)
            point3.circleRadius = 4
            point3.drawValuesEnabled = false
            
            pointsRendered.append(point1)
            pointsRendered.append(point2)
            pointsRendered.append(point3)
        }
        
        
        
        //combining polygon and points to be rendered in one variable called chartRendered. Then telling the chart (defined in the beginning of this file (dragged in from the view) that the data it should protray is the variable chartRendered
        let chartRendered = LineChartData(dataSets: [polygonSet, polygonSet2, polygonSet3] + pointsRendered)
        chart.data = chartRendered
        
        
    }

//PREPARING THE TABLE
    //Creating a list of variables
    let dataPoints = ["Zero fuel", "Take-off", "Landing"]
    let colors : [UIColor] = [.blue, .red, .green]
    
    //Function that specifies the number of rows. It is set to have the same amount as the number of variables
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPoints.count
    }
    
    //Function that defines the table and uses the identifier (given in the Main.storyboard to the prototype cell. The function appends the text to the appropiate cell as it iterates through them.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TakeoffFactorsTableViewCell
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(colors[indexPath.row].cgColor)
            ctx.cgContext.setStrokeColor(colors[indexPath.row].cgColor)
            ctx.cgContext.setLineWidth(10)
            
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        if let points = points {
            cell.colorSymbol.image = img
            cell.dataLabel.text = dataPoints[indexPath.row]
            cell.xCoordinateLabel.text = String(points[indexPath.row].x)
            cell.yCoordinateLabel.text = String(points[indexPath.row].y)
        }
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




