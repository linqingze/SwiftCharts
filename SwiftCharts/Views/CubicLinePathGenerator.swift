//
//  CubicLinePathGenerator.swift
//  SwiftCharts
//
//  Created by ischuetz on 28/04/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

open class CubicLinePathGenerator: ChartLinesViewPathGenerator {
    
    fileprivate let tension1: CGFloat
    fileprivate let tension2: CGFloat
    fileprivate var mControlPointList :[CGPoint] = []
    /**
    - parameter tension1: p1 tension, where 0 is straight line. A value higher than 0.3 is not recommended.
    - parameter tension2: p2 tension, where 0 is straight line. A value higher than 0.3 is not recommended.
    */
    public init(tension1: CGFloat, tension2: CGFloat) {
        self.tension1 = tension1
        self.tension2 = tension2
    }
    
    // src: http://stackoverflow.com/a/29876400/930450 (modified)
    open func generatePath(points: [CGPoint], lineWidth: CGFloat) -> UIBezierPath {
        
        let path = UIBezierPath()
        calculateControlPoint(pointList: points)
        guard !points.isEmpty else {return path}
        var p2: CGPoint

        path.lineCapStyle = .round
        path.lineJoinStyle = .round
                
        path.move(to: points.first!)
        
        for i in 0..<(points.count - 1) {
            p2 = points[i + 1]
            
            path.addCurve(to: p2, controlPoint1: mControlPointList[i], controlPoint2: mControlPointList[i + 1])
        }
        
        return path
    }
    
    open func generateAreaPath(points: [CGPoint], lineWidth: CGFloat) -> UIBezierPath {
        return generatePath(points: points, lineWidth: lineWidth)
    }
    private func calculateControlPoint(pointList: [CGPoint]) {
        mControlPointList.removeAll()
        if (pointList.count <= 1) {
            return
        }
        for (i, point) in pointList.enumerated() {
            if i == 0 {
                let nextPoint = pointList[i + 1]
                let controlX = point.x + (nextPoint.x - point.x) * self.tension1
                let controlY = point.y
                mControlPointList.append(CGPoint(x:controlX, y:controlY))
            } else if i < pointList.count - 1{
                let lastPoint = pointList[i - 1]
                let nextPoint = pointList[i + 1]
                let k = (nextPoint.y - lastPoint.y) / (nextPoint.x - lastPoint.x)
                let b = point.y - k * point.x
                //添加前控制点
                let lastControlX = point.x - (point.x - lastPoint.x) * self.tension1
                let lastControlY = k * lastControlX + b
                mControlPointList.append(CGPoint(x:lastControlX, y:lastControlY))
                //添加后控制点
                let nextControlX = point.x + (nextPoint.x - point.x) * self.tension2
                let nextControlY = k * nextControlX + b
                mControlPointList.append(CGPoint(x: nextControlX, y: nextControlY))
            }else{
                let lastPoint = pointList[i - 1]
                let controlX = point.x - (point.x - lastPoint.x) * self.tension2
                let controlY = point.y
                mControlPointList.append(CGPoint(x: controlX, y: controlY))
            }
        }
    }
}

