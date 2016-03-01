//
//  PRTransformLayer.swift
//  AnimationDemo
//
//  Created by JSHENG on 16/2/27.
//  Copyright © 2016年 JSHENG. All rights reserved.
//

import UIKit

class PRTransformLayer: CALayer {
    
   var progress: Int = 0
    var animationGroup: CGFloat = 0
    
   override init() {
        super.init()
    }
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
        let theLayer = layer as! PRTransformLayer
        progress = theLayer.progress
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - needsDisplayForKey
    override static func needsDisplayForKey(key: String) -> Bool {
        return key == "progress" ? true : super.needsDisplayForKey(key)
    }
  
    override func drawInContext(ctx: CGContext) {
    }
    
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        
    }
    func drawCircleWith(ctx: CGContext,color: CGColor, point1: CGPoint, point2: CGPoint, point3: CGPoint, point4:CGPoint) {
        let path = UIBezierPath()
        let p1 = point1
        let p2 = point2
        let p3 = point3
        let p4 = point4
        let line: CGFloat = 100
        
        path.moveToPoint(p1)
        let m1 = getLineMidPoint(p1, endPoint: p2, cornerLine: line)
        let m2 = getLineMidPoint(p2, endPoint: p3, cornerLine: line)
        let m3 = getLineMidPoint(p3, endPoint: p4, cornerLine: line)
        let m4 = getLineMidPoint(p4, endPoint: p1, cornerLine: line)
        path.addQuadCurveToPoint(p2, controlPoint: m1)
        path.addQuadCurveToPoint(p3, controlPoint: m2)
        path.addQuadCurveToPoint(p4, controlPoint: m3)
        path.addQuadCurveToPoint(p1, controlPoint: m4)
        
        CGContextAddPath(ctx, path.CGPath)
        CGContextSetFillColorWithColor(ctx, color)
        CGContextFillPath(ctx)
    }
    
    func halfPoint(point:CGPoint)->CGPoint {
        return CGPoint(x: point.x/2, y: point.y/2)
    }
    
    func getLineMidPoint(startPoint: CGPoint, endPoint: CGPoint, cornerLine: CGFloat)-> CGPoint{
        let size = cornerLine * 0.25
        var midX:CGFloat = 0
        var midY:CGFloat = 0
        midX = startPoint.x < endPoint.x ? startPoint.x - size : startPoint.x + size
        midY = startPoint.y < endPoint.y ? startPoint.y - size : startPoint.y + size
        return CGPoint(x: midX, y: midY)
    }
}
