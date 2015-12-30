//
//  PrayerCollectionViewController.swift
//  DribbbleReader
//
//  Created by naoyashiga on 2015/05/22.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

let reuseIdentifier_Prayer = "PrayerCollectionViewCell"

class PrayerCollectionViewController: UICollectionViewController{
    private var prayers:[Prayer] = [Prayer]() {
        didSet{
            self.collectionView?.reloadData()
        }
    }
    
    private var cellWidth:CGFloat = 0.0
    private var cellHeight:CGFloat = 0.0
    
    private let cellVerticalMargin:CGFloat = 20.0
    private let cellHorizontalMargin:CGFloat = 20.0
    
    var API_URL = Config.SHOT_URL
    var parentNavigationController = UINavigationController()
    
    var shotPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadShots(){
        self.collectionView!.backgroundColor = UIColor.hexStr("f5f5f5", alpha: 1.0)
        
        cellWidth = self.view.bounds.width
        cellHeight = self.view.bounds.height / 2.5
        
        self.collectionView?.registerNib(UINib(nibName: "PrayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier_Prayer)
        
        PrayerObjectHandler.getPrayers(API_URL, callback: {(prayers) -> Void in
            self.prayers = prayers
        })
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refreshInvoked:"), forControlEvents: UIControlEvents.ValueChanged)
        collectionView?.addSubview(refreshControl)
    }
    
    func refreshInvoked(sender:AnyObject) {
        sender.beginRefreshing()
        collectionView?.reloadData()
        sender.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prayers.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier_Prayer, forIndexPath: indexPath) as! PrayerCollectionViewCell
        
        let prayer = prayers[indexPath.row]
        
        //cell.imageView.sd_setImageWithURL(NSURL(string: prayer.imageUrl)!)
        
        cell.userIcon.sd_setImageWithURL(NSURL(string: prayer.avatarUrl)!)
        cell.userIcon.layer.cornerRadius = cell.userIcon.bounds.width / 2
        cell.userIcon.layer.masksToBounds = true
        
        cell.prayerTitle.text = prayer.prayerTitle
        cell.userName.text = prayer.userName
        cell.viewLabel.text = String(prayer.shotCount)
        
        
        if prayers.count - 1 == indexPath.row && shotPages < 5 {
            shotPages++
            print(shotPages)
            let url = API_URL + "&page=" + String(shotPages)
            PrayerObjectHandler.getPrayers(url, callback: {(prayers) -> Void in
//                self.shots = shots
                
                for prayer in prayers {
                    self.prayers.append(prayer)
                }
            })
        }

        
        //        DribbleObjectHandler.asyncLoadShotImage(shot, imageView: cell.imageView)
        PrayerObjectHandler.asyncLoadPrayerImage(prayer)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: cellWidth - cellHorizontalMargin, height: cellHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellVerticalMargin
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let _ = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier_Prayer, forIndexPath: indexPath) as! PrayerCollectionViewCell
        let prayer = prayers[indexPath.row]
        let vc = PrayerModalViewController(nibName: "PrayerModalViewController", bundle: nil)
        //let vc = ImageModalViewController(nibName: "ImageModalViewController", bundle: nil)
//        var vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.modalPresentationStyle = .FullScreen
        vc.modalTransitionStyle = .CrossDissolve
//        vc.parentNavigationController = parentNavigationController
        vc.pageUrl = prayer.htmlUrl
        vc.shotName = prayer.prayerTitle
        vc.designerName = prayer.userName
        
        let downloadQueue = dispatch_queue_create("com.teklabsco.processdownload", nil)
        
        dispatch_async(downloadQueue){
            let data = NSData(contentsOfURL: NSURL(string: prayer.imageUrl)!)
            
            var image: UIImage?
            
            if data != nil {
                prayer.imageData = data
                image = UIImage(data: data!)!
            }
            
            dispatch_async(dispatch_get_main_queue()){
                vc.imageView.image = image
            }
        }
        
        self.parentNavigationController.presentViewController(vc, animated: true, completion: nil)
//        self.parentNavigationController.pushViewController(vc, animated: true)
    }
}
