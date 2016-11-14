//
//  ViewController.swift
//  FinalAssessment4_CollectionView
//
//  Created by Chiu Chih-Che on 2016/11/5.
//  Copyright © 2016年 Jeff. All rights reserved.
//
//  CoreMotion參考文章：
//  https://github.com/maximbilan/iOS-CoreMotion-Example
//  http://www.cnblogs.com/lihaibo-Leao/p/4941848.html
//

import UIKit
import CoreMotion
import CoreLocation
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var itemOfIndex: Int?
    var changeTimes: Int = 0
    let motionManager = CMMotionManager()
    let pedometer = CMPedometer()
    var timer: NSTimer!
    let updateInterval: NSTimeInterval = 0.05 // 每秒採樣20次
    
    let locationManager = CLLocationManager()
    let locationCoordinate2D = CLLocationCoordinate2D(latitude: 25.052260,longitude: 121.532259)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = (UIScreen.mainScreen().bounds.width - 14 * 3) / 2
        print("UIScreen.mainScreen().bounds.width = \(UIScreen.mainScreen().bounds.width) , width = \(width)")
        layout.itemSize = CGSize(width: width, height: width)
        
        
//        let indexPath = NSIndexPath(forItem: 3, inSection: 0)
//        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ClickableCollectionViewCell
//        if(CMPedometer.isStepCountingAvailable()){
//            motionManager.deviceMotionUpdateInterval = updateInterval
//            
//            pedometer.startPedometerUpdatesFromDate(NSDate()) {
//                (data: CMPedometerData?, error) -> Void in
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    if(error == nil){
//                        print(data!.numberOfSteps)
//                        cell.button.titleLabel?.text = String(data!.numberOfSteps)
//                    }
//                })   
//            }
//        }
        
        //詢問權限
        self.locationManager.requestWhenInUseAuthorization()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ClickableCollectionViewCell
        cell.itemOfIndex = indexPath.item
        cell.delegate = self
        return cell
    }
}

extension ViewController: ClickableCollectionViewCellDelegate {
    func doCustomClick(itemOfIndex: Int) {
        let indexPath = NSIndexPath(forItem: itemOfIndex, inSection: 0)
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ClickableCollectionViewCell
        
        switch itemOfIndex {
        case 0: //顯示一個AlertView
            let alert = UIAlertController(title: "系統連線異常", message: nil, preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(ok)
            self.presentViewController(alert, animated: true, completion: nil)
        case 1: //顯示藍色，點擊後顯示紅色，再次點擊又會是藍色
            cell.button.backgroundColor = (changeTimes%2 == 0 ? UIColor.blueColor() : UIColor.redColor())
            changeTimes += 1
        case 2: //透過CoreMotion顯示使用者的步數，並且即時更新
            print("3")
            
        case 3:
            print("4")
        case 4:
            print("5")
            //取得目前位置 (實作CLLocationManagerDelegate)
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()
            
            //目的地
            var place = MKPlacemark(coordinate: locationCoordinate2D, addressDictionary: nil)
            let destination = MKMapItem(placemark: place)
            destination.name = "街角51法式創意手工派"
            
            //起始點
            place = MKPlacemark(coordinate: (self.locationManager.location?.coordinate)!, addressDictionary: nil)
            let source = MKMapItem(placemark: place)
            source.name = "目前位置"
            
            let items = [source, destination]
            
            // 打開地圖   launchOptions=>設定導航
            MKMapItem.openMapsWithItems(items, launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
        case 5:
            print("6")
        default:
            return
        }
        

    }
}

