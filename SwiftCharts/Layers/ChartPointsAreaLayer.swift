//
//  ChartPointsAreaLayer.swift
//  swiftCharts
//
//  Created by ischuetz on 15/04/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

open class ChartPointsAreaLayer<T: ChartPoint>: ChartPointsLayer<T> {
    
    fileprivate let areaColors: [UIColor]
    fileprivate let animDuration: Float
    fileprivate let animDelay: Float
    fileprivate let pathGenerator: ChartLinesViewPathGenerator
    fileprivate let addContainerPoints: Bool
    fileprivate var areaViews: [UIView] = []
    fileprivate let start: CGFloat

    public init(xAxis: ChartAxis, yAxis: ChartAxis, chartPoints: [T], areaColors: [UIColor], animDuration: Float, animDelay: Float, addContainerPoints: Bool,  pathGenerator: ChartLinesViewPathGenerator, start: CGFloat = 0) {
        self.areaColors = areaColors
        self.animDuration = animDuration
        self.animDelay = animDelay
        self.pathGenerator = pathGenerator
        self.addContainerPoints = addContainerPoints
        self.start = start
        super.init(xAxis: xAxis, yAxis: yAxis, chartPoints: chartPoints)
    }
    
    public convenience init(xAxis: ChartAxis, yAxis: ChartAxis, chartPoints: [T], areaColor: UIColor, animDuration: Float, animDelay: Float, addContainerPoints: Bool, pathGenerator: ChartLinesViewPathGenerator) {
        self.init(xAxis: xAxis, yAxis: yAxis, chartPoints: chartPoints, areaColors: [areaColor], animDuration: animDuration, animDelay: animDelay, addContainerPoints: addContainerPoints, pathGenerator: pathGenerator)
    }
    
    public init(xAxis: ChartAxis, yAxis: ChartAxis, chartPoints: [T], areaColors: [UIColor], animDuration: Float, animDelay: Float, addContainerPoints: Bool, front:Float, back:Float, pathGenerator: ChartLinesViewPathGenerator, start: CGFloat = 0) {
        self.areaColors = areaColors
        self.animDuration = animDuration
        self.animDelay = animDelay
        self.pathGenerator = pathGenerator
        self.addContainerPoints = addContainerPoints
        self.start = start
        super.init(xAxis: xAxis, yAxis: yAxis, chartPoints: chartPoints)
    }
    
    open override func display(chart: Chart) {        
        let areaView = ChartAreasView(points: chartPointScreenLocs, frame: chart.bounds, colors: areaColors, animDuration: animDuration, animDelay: animDelay, addContainerPoints: addContainerPoints, pathGenerator: pathGenerator, start: start)
        areaViews.append(areaView)
        chart.addSubview(areaView)
    }
}

