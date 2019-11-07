
//
//  CicadaTableViewCell.swift
//  Cicada
//
//  Created by 张琦 on 2017/5/17.
//  Copyright © 2017年 com. All rights reserved.
//

import Foundation
import UIKit

class CicadaTableViewCell: UITableViewCell {
    
    var imageViewC : UIImageView?
    var titleLabel : UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.customUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //要去掉fatalError,fatalError的意思是无条件停止执行并打印
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func customUI() {
        //
        imageViewC = UIImageView(frame : CGRect (x:20,y:0,width:40,height:40))
        imageViewC?.backgroundColor = UIColor.cyan
        self.contentView.addSubview(imageViewC!);
        
        titleLabel = UILabel(frame : CGRect (x:20 ,y:(imageViewC?.bottom)! + 20 ,width:KScreenWidth ,height:12))
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        titleLabel?.textColor = UIColor.blue
        self.contentView.addSubview(titleLabel!)
    }
    
   class func cicadaTableViewCell(tableView:UITableView) -> AnyObject {
        let cellId:String = "CicadaCellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = CicadaTableViewCell.init(style: .default, reuseIdentifier: cellId)
        }
        cell?.selectionStyle = .none
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
