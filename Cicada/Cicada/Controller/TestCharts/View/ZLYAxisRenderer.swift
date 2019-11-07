//
//  ZLYAxisRenderer.swift
//  Cicada
//
//  Created by 张琦 on 2018/5/3.
//  Copyright © 2018年 com. All rights reserved.
//

import Foundation

open class ZLYAxisRenderer : YAxisRenderer {
    
    public override init(viewPortHandler: ViewPortHandler?, yAxis: YAxis?, transformer: Transformer?) {
        super.init(viewPortHandler: viewPortHandler!, yAxis: yAxis, transformer: transformer)
    }
    
    open override func renderAxisLabels(context: CGContext) {
        super.renderAxisLabels(context: context)
        guard let yAxis = self.axis as? ZLYAxis,
            let viewPortHandler = self.viewPortHandler as? ViewPortHandler
            else {return}
        
        if !yAxis.isEnabled || !yAxis.isDrawLabelsEnabled
        {
            return
        }
        let xoffset = yAxis.xOffset
        let yoffset = yAxis.labelFont.lineHeight / 2.5 + yAxis.yOffset
        
        let dependency = yAxis.axisDependency
        let labelPosition = yAxis.labelPosition
//        let labelPositionType = yAxis.labelPositionType
        
        var xPos = CGFloat(0.0)
        
        var textAlign: NSTextAlignment
        
        if dependency == .left {
            if labelPosition == .outsideChart {
                textAlign = .right
                xPos = viewPortHandler.offsetLeft - xoffset
            } else {
                textAlign = .left
                xPos = viewPortHandler.offsetLeft + xoffset
            }
        } else {
            if labelPosition == .insideChart {
                textAlign = .left
                xPos = viewPortHandler.contentRight + xoffset
            } else {
                textAlign = .right
                xPos = viewPortHandler.contentRight - xoffset
            }
        }
        
        drawZLYLabels(context: context, fixedPosition: xPos, positions: transformedPositions(), offset: yoffset - yAxis.labelFont.lineHeight, textAlign: textAlign)
        
    }
    
    internal func drawZLYLabels(context:CGContext,fixedPosition:CGFloat,positions:[CGPoint],offset:CGFloat,textAlign:NSTextAlignment) {
        
    }
    
}
