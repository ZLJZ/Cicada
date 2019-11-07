
//
//  ZLYAxis.swift
//  Cicada
//
//  Created by 张琦 on 2018/5/2.
//  Copyright © 2018年 com. All rights reserved.
//

import Foundation

open class ZLYAxis:YAxis {
    @objc
    public enum LabelPositionType:Int
    {
        case B_T_LineTop_InnerTop//自下而上，label在网格线上边，最上边label在线内部
        case T_B_LineBottom_InnerBottom//自上而下，label在网格线下边，最下边label在线内部
    }
    open var labelPositionType = LabelPositionType.B_T_LineTop_InnerTop
    open var leftYValueArr : NSArray?
    
    public override init() {
        super.init()
    }
    
}
