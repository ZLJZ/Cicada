//
//  ZLBarChartView.swift
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

/// Chart that draws bars.
open class ZLBarChartView: BarChartView
{
    internal var _animator: Animator!
    internal var _viewPortHandler: ViewPortHandler!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        _animator = Animator()
        _animator.delegate = self
        
        _viewPortHandler = ViewPortHandler(width: bounds.size.width, height: bounds.size.height)
        _viewPortHandler.setChartDimens(width: bounds.size.width, height: bounds.size.height)
        
        renderer = ZLBarChartRenderer(dataProvider: self, animator: _animator, viewPortHandler: _viewPortHandler)
    }

    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

