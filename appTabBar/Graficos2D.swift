//
//  Graficos2D.swift
//  appTabBar
//
//  Created by Guest User on 30/05/22.
//

import UIKit

class Graficos2D: UIView {

    override func draw(_ rect: CGRect) {
        
        let canvas = UIGraphicsGetCurrentContext()
                
        canvas?.setLineWidth(3.0)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components:[CGFloat] = [CGFloat(Float.random(in: 0..<1)),CGFloat(drand48()),0.0,1.0]
        
        let color = CGColor(colorSpace: colorSpace, components: components)
        canvas?.strokePath()
        canvas?.setStrokeColor(color!)
        
        
        
        let ancho = rect.width
        let alto = rect.height
        let font = UIFont(name: "Arial", size: 30)
            
        let stringAncho = NSAttributedString(string: "Ancho = \(ancho)", attributes: [NSAttributedString.Key.font: font!, NSAttributedString.Key.backgroundColor: color!])
        stringAncho.draw(at: CGPoint(x: 10, y: 600))
        
        let stringAlto = NSAttributedString(string: "Alto = \(alto)", attributes: [NSAttributedString.Key.font: font!, NSAttributedString.Key.backgroundColor: color!])
        stringAlto.draw(at: CGPoint(x: 10, y: 650))

        
        for x in stride(from: ancho/2 - 200, to: ancho/2, by: 15)
        {
            let y = alto/2 - (x-10) * 0.4
            canvas?.move(to: CGPoint(x:x, y:alto/2))
            canvas?.addLine(to: CGPoint(x: ancho/2, y: y))
            canvas?.setStrokeColor(color!)
            canvas?.strokePath()
        }

        for x in stride(from: ancho/2, to: 407, by: 15)
        {
            let y = alto/2 - 77 + (x - ancho/2) * 0.4
            canvas?.move(to: CGPoint(x:x, y:alto/2))
            canvas?.addLine(to: CGPoint(x: ancho/2, y: y))
            canvas?.strokePath()
        }
        
        
        for x in stride(from: ancho/2  + 200, to: ancho/2, by: -15)
        {
            let y = alto/2 + 77 - (x - ancho/2) * 0.4
            canvas?.move(to: CGPoint(x:x, y:alto/2))
            canvas?.addLine(to: CGPoint(x: ancho/2, y: y))
            canvas?.strokePath()
        }
        
        for x in stride(from: ancho/2, to: 10, by: -15)
        {
            let y = alto/2 + 77 - (ancho/2 - x) * 0.4
            canvas?.move(to: CGPoint(x:x, y:alto/2))
            canvas?.addLine(to: CGPoint(x: ancho/2, y: y))
            canvas?.setStrokeColor(color!)
            canvas?.strokePath()
        }
    }

}
