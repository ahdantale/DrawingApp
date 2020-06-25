//
//  CanvasView.swift
//  DrawingApp
//
//  Created by Abhishek Dantale on 24/06/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    //Array for the line
    // var lines : [CGPoint]?
    
    //Array for multiple lines
    // var multiLines = [[CGPoint]]()
    
    //Variable for the stroke colour
    var strokeColour : UIColor = UIColor.black
    
    //Variable for the stroke width
    var strokeWidth : CGFloat = 2.0
    
    //Array for the new Line
    var lines : Line?
    
    //Array for the multiple line
    var multiLines = [Line]()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.drawMultContiLines()
    }
    
    //Function to draw a line on the current context
    func drawLine() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(4.0)
        
        let startPoint = CGPoint(x: 100, y: 100)
        let endPoint = CGPoint(x: 450, y: 450)
        
        context.move(to: startPoint)
        context.addLine(to: endPoint)
        
        context.strokePath()
    }
    
    //Function to draw a line using touches on the current context
    func drawContLine() {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(4.0)
        
        for (index,point) in self.lines!.points.enumerated() {
            if index == 0 {
                context.move(to: point)
            } else {
                context.addLine(to: point)
            }
        }
        
        context.strokePath()
        
    }
    
    //Function to draw multiple lines
    func drawMultContiLines() {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        for aLine in multiLines {
            
            context.setStrokeColor(aLine.colour.cgColor)
            context.setLineWidth(aLine.width)
            context.setLineCap(.round)
            
            for (index,point) in aLine.points.enumerated() {
                if index == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
            context.strokePath()
        }
        
    }
    
    //Function to get the first touches when touches begin in the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstPoint = touches.first?.location(in: nil) else { return }
        print(firstPoint)
        self.multiLines.append(Line(colour: self.strokeColour, width: self.strokeWidth, points: [CGPoint]()))
    }
    
    //Function to get the first touch when the touches move
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstPoint = touches.first?.location(in: nil) else { return }
        print("Touches Moved : \(firstPoint)")
        self.lines = self.multiLines.popLast()
        self.lines?.points.append(firstPoint)
        self.multiLines.append(self.lines!)
        self.setNeedsDisplay()
    }
    
    //Function to append the lines array to the multiLine multi-dimensional array
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

}
