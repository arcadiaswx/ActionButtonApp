//
//  NotificationCollectionViewController.swift
//  ActionButtonApp
//
//  Created by teklabsco on 12/22/15.
//  Copyright © 2015 Teklabs, LLC. All rights reserved.
//

import UIKit

let reuseIdentifier_Notif = "NotificationCollectionViewCell"

class NotificationCollectionViewController: UICollectionViewController{
    private var notifications:[Notification] = [Notification]() {
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
    
    var notificationPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadShots(){
        self.collectionView!.backgroundColor = UIColor.hexStr("f5f5f5", alpha: 1.0)
        
        cellWidth = self.view.bounds.width
        cellHeight = self.view.bounds.height / 2.5
        
        self.collectionView?.registerNib(UINib(nibName: "NotificationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier_Notif)
        
        NotificationObjectHandler.getNotifications(API_URL, callback: {(notifications) -> Void in
            self.notifications = notifications
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
        return notifications.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier_Notif, forIndexPath: indexPath) as! NotificationCollectionViewCell
        
        let notification = notifications[indexPath.row]
        
        cell.imageView.sd_setImageWithURL(NSURL(string: notification.imageUrl)!)
        //        cell.imageView.layer.shadowColor = UIColor.blackColor().CGColor
        //        cell.imageView.layer.shadowOffset = CGSize(width: 0, height: 10)
        //        cell.imageView.layer.shadowOpacity = 0.8
        //        cell.imageView.layer.shadowRadius = 5
        
        cell.designerIcon.sd_setImageWithURL(NSURL(string: notification.avatarUrl)!)
        cell.designerIcon.layer.cornerRadius = cell.designerIcon.bounds.width / 2
        cell.designerIcon.layer.masksToBounds = true
        
        cell.notificationName.text = notification.notificationName
        cell.designerName.text = notification.designerName
        cell.viewLabel.text = String(notification.notificationCount)
        
        
        if notifications.count - 1 == indexPath.row && notificationPages < 5 {
            notificationPages++
            print(notificationPages)
            let url = API_URL + "&page=" + String(notificationPages)
            DribbleObjectHandler.getShots(url, callback: {(notifications) -> Void in
                //                self.notifications = notifications
                
                for notification in notifications {
                    self.notifications.append(notification)
                }
            })
        }
        
        //        cell.imageView.bounds = CGRectMake(0, 0, cellWidth, cellHeight)
        //        cell.imageView.frame = cell.imageView.bounds
        //        cell.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        
        //        cell.animatedImageView.bounds = CGRectMake(0, 0, cellWidth, cellHeight)
        //        cell.animatedImageView.frame = cell.animatedImageView.bounds
        //        cell.animatedImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        //        cell.contentView.backgroundColor = UIColor.yellowColor()
        
        //        let imageLoadQueue = dispatch_queue_create("imageLoadQueue", nil)
        //
        //        SDWebImageDownloader.sharedDownloader().downloadImageWithURL(
        //            NSURL(string: notification.imageUrl),
        //            options: SDWebImageDownloaderOptions.UseNSURLCache,
        //            progress: nil,
        //            completed: { (image: UIImage!, data: NSData!, error: NSError!, finished: Bool) -> Void in
        //                if finished {
        //                    dispatch_async(imageLoadQueue, {
        //                        let animatedImage = FLAnimatedImage(animatedGIFData: data)
        //                        if let animatedImage = animatedImage {
        //                            dispatch_async(dispatch_get_main_queue(), {
        //                                cell.animatedImageView.animatedImage = FLAnimatedImage(GIFData: data)
        //                            })
        //                        }
        //                    })
        //                }
        //
        //        })
        
        //        DribbleObjectHandler.asyncLoadShotImage(notification, imageView: cell.imageView)
        
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
        let _ = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier_Notif, forIndexPath: indexPath) as! NotificationCollectionViewCell
        let notification = notifications[indexPath.row]
        let vc = ImageModalViewController(nibName: "ImageModalViewController", bundle: nil)
        //        var vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.modalPresentationStyle = .FullScreen
        vc.modalTransitionStyle = .CrossDissolve
        //        vc.parentNavigationController = parentNavigationController
        vc.pageUrl = notification.htmlUrl
        vc.notificationName = notification.notificationName
        vc.designerName = notification.designerName
        
        let downloadQueue = dispatch_queue_create("com.naoyashiga.processdownload", nil)
        
        dispatch_async(downloadQueue){
            let data = NSData(contentsOfURL: NSURL(string: notification.imageUrl)!)
            
            var image: UIImage?
            
            if data != nil {
                notification.imageData = data
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
