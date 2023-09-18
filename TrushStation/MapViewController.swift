//
//  ViewController.swift
//  TrushStation
//
//  Created by 長島啓太朗 on 2023/09/17.
//

import UIKit
import MapKit
class MapViewController: UIViewController,CLLocationManagerDelegate {
    @IBOutlet weak var mapKitView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // CLLocationManagerのインスタンス生成
        var locationManager = CLLocationManager()
        
        //位置情報サービスの確認
        CLLocationManager.locationServicesEnabled()
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.notDetermined) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.delegate = self
        //位置情報を使用可能か
        if CLLocationManager.locationServicesEnabled() {

        //位置情報の取得開始
          locationManager.startUpdatingLocation()

        }
        // セキュリティ認証のステータス
       
    }
    
    // 位置情報を取得した場合
    @IBAction func position(){
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let newLocation = locations.last else {
                      return
                 }
            let location:CLLocationCoordinate2D
                        = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
            print("緯度：", location.latitude, "経度：", location.longitude)
        }
      
    }
    
    

}

