//
//  CicadaModel.swift
//  Cicada
//
//  Created by 张琦 on 2017/5/18.
//  Copyright © 2017年 com. All rights reserved.
//

import Foundation

class CicadaModel: NSObject {
    //
    var title : String
    var imageName : String
    
    init(title:String,imageName:String) {
        self.title = title
        self.imageName = imageName
        super.init()
    }
    
    init(coder aDecoder:NSCoder!) {
//  
        self.title = aDecoder.decodeObject(forKey: "title") as!String
        self.imageName = aDecoder.decodeObject(forKey: "imageName") as!String
    }
    
    func encodeWithCoder(aCoder:NSCoder!) {
        aCoder.encode(title,forKey:"title")
        aCoder.encode(imageName,forKey:"imageName")
    }
    
    
}
