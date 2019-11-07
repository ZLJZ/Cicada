//
//  CicadaViewController.swift
//  Cicada
//
//  Created by 张琦 on 2017/5/17.
//  Copyright © 2017年 com. All rights reserved.
//

import Foundation
import UIKit



class CicadaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
//    let cellId:String = "CicadaCellId"
    var tableViewC : UITableView?
    var dataSource  = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = COLOR_BACK
        createTableView()
    }
    
    func createTableView(){
        dataSource = ["H","U","S","K","Y","C","I","C","A","D","A"]
        tableViewC = UITableView(frame: CGRect(x:0,y:0,width:KScreenWidth,height:KScreenHeight),style:.plain)
        tableViewC?.backgroundColor = UIColor.cyan
        tableViewC?.delegate = self
        tableViewC?.dataSource = self
        tableViewC?.bounces = false
        tableViewC?.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 0)//分割线距离左边20
//        tableViewC?.tableHeaderView = UIView()
//        tableViewC?.tableFooterView = UIView()
//        tableViewC?.rowHeight = UITableViewAutomaticDimension
//        tableViewC?.estimatedRowHeight = 120
//        tableViewC?.register(CicadaTableViewCell.classForCoder(), forCellReuseIdentifier: cellId)
        self.view.addSubview(tableViewC!)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = tableView.cellForRow(at: indexPath) as!CicadaTableViewCell
//        return (cell.titleLabel?.height)!
        return 120
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CicadaTableViewCell
        let cell = CicadaTableViewCell.cicadaTableViewCell(tableView: tableView) as!CicadaTableViewCell
        

        cell.titleLabel?.text = dataSource[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let praticeControlViewController = PraticeControlViewController()
            self.navigationController?.pushViewController(praticeControlViewController, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //
        if scrollView == tableViewC {
//            print("scrollView" + String.init(format:"%.2f",scrollView.contentOffset.y));
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
