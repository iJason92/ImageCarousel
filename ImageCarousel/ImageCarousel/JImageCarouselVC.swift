//
//  JImageCarouselVC.swift
//  ImageCarousel
//
//  Created by Jason on 16/5/15.
//  Copyright (c) 2015年 Shepherd. All rights reserved.
//


import UIKit

let reuseIdentifier = "JImageCarouselCell"

class JImageCarouselVC: UICollectionViewController {
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    // 得到图片数组名
    lazy var imgList : [String] = {
        var arrM :[String] = Array()
        for i in 1...10 {
            arrM.append("\(i).png")
        }
        return arrM
    }()
    
    // 设置图像的索引 一开始是0
    var curIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 设置布局属性
        layout.itemSize = collectionView!.bounds.size
        
        // 水平间距
        layout.minimumInteritemSpacing = 0;
        
        // 行间距
        layout.minimumLineSpacing = 0;
        
        // 设置滚动方向
        layout.scrollDirection = UICollectionViewScrollDirection(rawValue:1)!
        
        // 设置分页
        collectionView!.pagingEnabled = true;
        
        self.collectionView!.showsHorizontalScrollIndicator = false;
        
        // 开始时就定位到第一页
        let indexPath = NSIndexPath(forItem: 1, inSection: 0)
        collectionView!.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
    }
    
    // MARK: - 实现UICollectionViewController的数据源方法
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imgList.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // 尝试从指定缓存池中加载cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! JImageCarouselCell
        
        let index = (indexPath.item - 1 + imgList.count + curIndex ) % imgList.count
        
        cell.setCell(imgList[index])
        
        return cell;
    }
    
    // MARK: - 实现UIScrollView滚动结束后的代理方法
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let offset = Int(collectionView!.contentOffset.x / collectionView!.bounds.size.width) - 1
        
        if offset != 0 {
            curIndex = (curIndex + imgList.count + offset ) % imgList.count
            let indexPath = NSIndexPath(forItem: 1, inSection: 0)
            collectionView!.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
            
            UIView.setAnimationsEnabled(false)
            
            self.collectionView!.reloadItemsAtIndexPaths([indexPath])
            
            UIView.setAnimationsEnabled(true)
            
        }
    }
    
}

class JImageCarouselCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    // 设置cell的图片
    func setCell(imgName : String) {
        imgView.image = UIImage(named: imgName)
    }
}


