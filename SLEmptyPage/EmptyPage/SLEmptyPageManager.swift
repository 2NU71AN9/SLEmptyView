//
//  SLEmptyPageManager.swift
//  XiaocaoPlusNew
//
//  Created by X.T.X on 2018/1/17.
//  Copyright © 2018年 shiliukeji. All rights reserved.
//

import UIKit

public class SLEmptyPageManager {
    
    static var defaultEmptyView: UIView.Type = SLEmptyView.self
    /// 默认展示图片
    public static var defaultImage: UIImage? = {
        let path = Bundle(for: SLEmptyView.self).resourcePath! + "/Resource.bundle"
        let CABundle = Bundle(path: path)!
        return UIImage(named: "emptyImage", in:  CABundle, compatibleWith: nil)
    }()
    /// 默认提示内容, nil时隐藏label
    public static var defaultText: String? = "没有找到任何内容哦~"
    /// 默认按钮文字, nil时隐藏按钮
    public static var defaultActionTitle: String? = "重新加载"
    /// 默认按钮背景颜色
    public static var defaultActionBackColor: UIColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
    
    public static var enable: Bool = false {
        didSet {
            enable ? SLEmptyPageManager.begin() : ()
        }
    }
    private static var exchanged = false // 是否已经进行过
    private static func begin() {
        if exchanged { return }
        exchanged = true
        
        RunTime.exchangeMethod(selector: #selector(UITableView.reloadData),
                               replace: #selector(UITableView.table_emptyReloadData),
                               class: UITableView.self)
        
        RunTime.exchangeMethod(selector: #selector(UITableView.layoutSubviews),
                               replace: #selector(UITableView.table_emptyLayoutSubviews),
                               class: UITableView.self)
        
        RunTime.exchangeMethod(selector: #selector(UITableView.insertRows(at:with:)),
                               replace: #selector(UITableView.table_emptyInsertRows(at:with:)),
                               class: UITableView.self)
        
        RunTime.exchangeMethod(selector: #selector(UITableView.deleteRows(at:with:)),
                               replace: #selector(UITableView.table_emptyDeleteRows(at:with:)),
                               class: UITableView.self)
        
        RunTime.exchangeMethod(selector: #selector(UITableView.insertSections(_:with:)),
                               replace: #selector(UITableView.table_emptyInsertSections(_:with:)),
                               class: UITableView.self)
        
        RunTime.exchangeMethod(selector: #selector(UITableView.deleteSections(_:with:)),
                               replace: #selector(UITableView.table_emptyDeleteSections(_:with:)),
                               class: UITableView.self)
        
        RunTime.exchangeMethod(selector: #selector(UICollectionView.reloadData),
                               replace: #selector(UICollectionView.coll_emptyReloadData),
                               class: UICollectionView.self)
        
        RunTime.exchangeMethod(selector: #selector(UICollectionView.layoutSubviews),
                               replace: #selector(UICollectionView.coll_emptyLayoutSubviews),
                               class: UICollectionView.self)
        
        RunTime.exchangeMethod(selector: #selector(UICollectionView.insertItems(at:)),
                               replace: #selector(UICollectionView.coll_emptyInsertItems(at:)),
                               class: UICollectionView.self)
        
        RunTime.exchangeMethod(selector: #selector(UICollectionView.deleteItems(at:)),
                               replace: #selector(UICollectionView.coll_emptyDeleteItems(at:)),
                               class: UICollectionView.self)
        
        RunTime.exchangeMethod(selector: #selector(UICollectionView.insertSections(_:)),
                               replace: #selector(UICollectionView.coll_emptyInsertSections(_:)),
                               class: UICollectionView.self)
        
        RunTime.exchangeMethod(selector: #selector(UICollectionView.deleteSections(_:)),
                               replace: #selector(UICollectionView.coll_emptyDeleteSections(_:)),
                               class: UICollectionView.self)
    }
}
