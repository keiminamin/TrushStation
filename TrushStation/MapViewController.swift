//
//  ViewController.swift
//  TrushStation
//
//  Created by 長島啓太朗 on 2023/09/17.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController,CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapKitView: MKMapView!
    @IBOutlet var modalButton: UIButton!
    @IBOutlet var positionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        modalButton.layer.cornerRadius = 35
        positionButton.layer.cornerRadius = 35
    }
    
    // 位置情報を取得した場合
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("location: \(location)") // CLLocationManagerクラスで取得した位置情報
            print("緯度: \(location.coordinate.latitude)")
            print("経度: \(location.coordinate.longitude)")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("error: \(error)")
       }
    @IBAction func searchPosition(_ sender: UIButton){
       locationManager.requestLocation()
      
    }
    
}

