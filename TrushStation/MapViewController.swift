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
    var latitudeNow: Double = 0
    var longitudeNow: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        modalButton.layer.cornerRadius = 35
        positionButton.layer.cornerRadius = 35
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: mapKitView.centerCoordinate, span: span)
        mapKitView.region = region
        mapKitView.setCenter(mapKitView.userLocation.coordinate, animated: false)
        mapKitView.userTrackingMode = .follow
       

    }
    
    // 位置情報を取得した場合
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                print("location: \(location)") // CLLocationManagerクラスで取得した位置情報
                print("緯度: \(location.coordinate.latitude)")
                print("経度: \(location.coordinate.longitude)")
                self.latitudeNow = Double(location.coordinate.latitude)
                self.longitudeNow = Double(location.coordinate.latitude)
            }
       
       
       
        }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("error: \(error)")
       }
    @IBAction func searchPosition(_ sender: UIButton){
       locationManager.requestLocation()
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let status = CLLocationManager.authorizationStatus()
        let next = segue.destination
        if segue.identifier == "toAddModal"{
            if status == .authorizedWhenInUse{
                let saveViewController = segue.destination as! SaveViewController
                print(String(longitudeNow))
                print(String(latitudeNow))
                saveViewController.longitudeNow = longitudeNow
                saveViewController.latitudeNow = latitudeNow
            }else{
                print("NO")
            }
            if let sheet = next.sheetPresentationController {
                sheet.detents = [.medium()]
            }
        }
    }
    
}

