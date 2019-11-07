//
//  ZLBarChartRenderer.swift
//  Cicada
//
//  Created by 吴肖利 on 2018/9/4.
//  Copyright © 2018 com. All rights reserved.
//

import Foundation
import CoreGraphics
#if !os(OSX)
import UIKit
#endif

open class ZLBarChartRenderer: BarChartRenderer
{
    public override init(dataProvider: BarChartDataProvider?, animator: Animator?, viewPortHandler: ViewPortHandler?)
    {
        super.init(dataProvider: dataProvider!, animator: animator!, viewPortHandler: viewPortHandler!)
        self.dataProvider = dataProvider
    }
    
    open override func drawHighlighted(context: CGContext, indices: [Highlight])
    {
        guard
            let dataProvider = dataProvider,
            let barData = dataProvider.barData
            else { return }
        
        context.saveGState()
        
        var barRect = CGRect()
        
        for high in indices
        {
            guard
                let set = barData.getDataSetByIndex(high.dataSetIndex) as? IBarChartDataSet,
                set.isHighlightEnabled
                else { continue }
            
            if let e = set.entryForXValue(high.x, closestToY: high.y) as? BarChartDataEntry
            {
                if !isInBoundsXZL(entry: e, dataSet: set)
                {
                    continue
                }
                
                let trans = dataProvider.getTransformer(forAxis: set.axisDependency)
                
                context.setFillColor(set.highlightColor.cgColor)
                //颜色之所以不一样就是因为在此处设置了透明度
//                context.setAlpha(set.highlightAlpha)
                
                let y1: Double = set.yMax
                let y2: Double = 0.0
                
                prepareBarHighlight(x: e.x, y1: y1, y2: y2, barWidthHalf: barData.barWidth / 2.0, trans: trans, rect: &barRect)
                
                setHighlightDrawPosZL(highlight: high, barRect: barRect)
                
                context.fill(barRect)
            }
        }
        
        context.restoreGState()
    }
    
    
    func isInBoundsXZL(entry e: ChartDataEntry, dataSet: IBarLineScatterCandleBubbleChartDataSet) -> Bool
    {
        let entryIndex = dataSet.entryIndex(entry: e)
        
        if Double(entryIndex) >= Double(dataSet.entryCount) * (animator.phaseX)
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    
    func setHighlightDrawPosZL(highlight high: Highlight, barRect: CGRect)
    {
        high.setDraw(x: barRect.midX, y: barRect.origin.y)
    }

}



