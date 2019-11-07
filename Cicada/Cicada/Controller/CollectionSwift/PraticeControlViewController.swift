//
//  PraticeControlViewController.swift
//  Cicada
//
//  Created by 张琦 on 2017/5/22.
//  Copyright © 2017年 com. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PraticeControlViewController: UIViewController {
    var button:UIButton!
    var label:UILabel!
    var imageView:UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = COLOR_BACK
        self.navigationItem.title = "why"
        let arr1 : NSArray = ["1","22","333"]
        print(arr1)
        for str in arr1
        {
            print(str)
        }
        
        var dic : [String : Any] = ["wu":"ww","xiao":"xx","li":"ll"]
        print(dic)
        for key in dic {
            print(key)
            print(key.value)
        }
        for (key,value) in dic {
            print("HH--",key)
            print("HH--",value)
        }
        dic.removeValue(forKey: "wu")
        
        print(dic)
    
        customUI()
        //
        let requestUrl = URL.init(string: "https://tnhq.tpyzq.com/note/send")
        let params = ["phone":"18701626374"]
        
        Alamofire.request(requestUrl!, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            //
            switch response.result.isSuccess {
            case true:
                let dic = response.result.value as![String:Any]
                let codeStr = dic["code"] as!String
                print(dic)
                if  codeStr == "200" {
                    self.button .setTitle("成功", for: .normal)
                } else {
                    print("打印错误message**" + String(describing: dic["message"]!))
                }
            case false:
                print(response.result.error!)
            }
        }
        
    
        
    }
    
    func customUI() {
        
        button = UIButton.init(type: .custom)
        let titleStr:String = "知了"
        
        let size:CGSize = ToolHelper.size(forNoticeTitle: titleStr, font: UIFont.systemFont(ofSize: 13))
        button = UIButton(frame:CGRect(x:100,y:100,width:size.width,height:size.height))
        button.backgroundColor = COLOR_RED
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitle("知了", for: .normal)
        button.setTitleColor(COLOR_LIGHTGRAY, for: .normal)
        button.tag = 7
        
        
        button.addTarget(self, action:#selector(clickButton7(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        let labelTitleStr:String = "不知道写点啥"
//        let labelSize = ToolHelper.size(forNoticeTitle: labelTitleStr, font: UIFont.systemFont(ofSize: 15))
//        label = UILabel.init(frame: CGRect(x:button.right + 40 ,y:button.bottom + 40 ,width:labelSize.width,height:labelSize.height))
        label = UILabel.init(frame: CGRect(x:button.right + 40 ,y:button.bottom + 40 ,width:130,height:50))
        
        label.textAlignment = .center
//        label.adjustsFontSizeToFitWidth = true
        label.text = labelTitleStr
        label.backgroundColor = COLOR_GREEN
        label.textColor = COLOR_YELLOW
        label.font = UIFont.systemFont(ofSize: 15)
        label.isUserInteractionEnabled = true
        ///
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        ///
        label.layer.borderColor = COLOR_RED?.cgColor
        label.layer.borderWidth = 2
        
        self.view.addSubview(label)
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapLabel(tap:)))
        label.addGestureRecognizer(tap)
        
        imageView = UIImageView.init(frame:CGRect(x:label.left,y:label.bottom + 40,width:40,height:40))
        imageView.contentMode = .center
        let image:UIImage = UIImage.init(named: "more_icon_-transfer")!
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        self.view.addSubview(imageView)
        
        let imageViewTap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapImageView(tap:)))
        imageView.addGestureRecognizer(imageViewTap)
        
        
        
    }
    
    @objc func tapImageView(tap:UITapGestureRecognizer) {
        print("点击了imageView--警告图片。。。")
    }
    
    @objc func tapLabel(tap:UITapGestureRecognizer) {
        print("点击了label--不知道写点啥。。。")
    }
    
    @objc func clickButton7(sender:UIButton) -> Void {
        if sender.tag == 7 {
            print("777777")
        } else {
            print("!!!")
        }
    }
    
    func clickButton() {
        print("点击知了按钮")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
