//
//  ZLMarkerView.swift
//  Cicada
//
//  Created by 吴肖利 on 2018/8/20.
//  Copyright © 2018年 com. All rights reserved.
//

import Foundation
open class ZLMarkerView: MarkerImage {
    var color: UIColor?
    var textColor: UIColor
    var font: UIFont
    var insets: UIEdgeInsets
    var view: UIView?
    var label: String?
    var _drawAttributes = [NSAttributedString.Key : AnyObject]()
    var labelText: String?
    var paragraphStyle: NSMutableParagraphStyle
    
    @objc public init(color: UIColor, textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment, insets: UIEdgeInsets) {
        self.color = color
        self.textColor = textColor
        self.font = font
        self.insets = insets
        self.paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        self.paragraphStyle.alignment = textAlignment
        super.init()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        setLabel(entry: entry)
    }
    
    open override func draw(context: CGContext, point: CGPoint) {
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        let rect = CGRect(
            origin: CGPoint(
                x: offset.x,
                y: offset.y),
            size: size)
        
        context.saveGState()

        if let color = color
        {
            context.setFillColor(color.cgColor)
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y+rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.fillPath()
        }

        UIGraphicsPushContext(context)
        
        labelText?.draw(in: rect, withAttributes: _drawAttributes)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint {
        let size = self.size
        var point = point
        point.x = LineViewWidth - size.width - 10;//需减10 因为左Y轴和右Y轴到LineChartView的边界的距离均为5
        point.y -= size.height/2.0;
        return point
    }
    

    func setLabel(entry: ChartDataEntry) {
        _drawAttributes.removeAll()
        _drawAttributes[.font] = self.font
        _drawAttributes[.foregroundColor] = self.textColor
        _drawAttributes[.backgroundColor] = self.color
        _drawAttributes[.paragraphStyle] = self.paragraphStyle
        labelText = String(format: "%.2f",entry.y)
        let labelSize = labelText?.size(withAttributes: _drawAttributes)
        var size = CGSize()
        size.width = (labelSize?.width)! + insets.left + insets.right
        size.height = (labelSize?.height)! + insets.top + insets.bottom
        self.size = size
    }

}
