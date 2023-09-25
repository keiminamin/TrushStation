//
//  ViewController.swift
//  TrushStation
//
//  Created by 長島啓太朗 on 2023/09/17.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift
class TrushAnnotation: NSObject, MKAnnotation {

    public var coordinate: CLLocationCoordinate2D
    public var title: String?
    public var subtitle: String?
    public var titleVisibility: Bool?
    public var subtitleVisibility: Bool?
    public init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, titleVisibility: Bool,subtitleVisibility: Bool) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.titleVisibility = titleVisibility
        self.subtitleVisibility = subtitleVisibility
    }

}
class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    let locationManager = CLLocationManager()
    let realm = try! Realm()
    @IBOutlet weak var mapKitView: MKMapView!
    @IBOutlet var modalButton: UIButton!
    @IBOutlet var positionButton: UIButton!
    var latitudeNow: Double = 0
    var longitudeNow: Double = 0
    var trushLatitude: Double = 0
    var trushLogitude: Double = 0
    var isFireTrush: Bool = false
    var isNotFireTrush: Bool = false
    var isPet:Bool = false
    var isCan:Bool = false
    var garbages:Results<Garbage>!
    var numberTitle:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        mapKitView.delegate = self
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
        garbages = readGarbages()
        setTrushBox()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("saved")
        garbages = readGarbages()
        setTrushBox()
       
    }
    func setTrushBox(){
       
        for garbage in garbages{
            print(garbage.trushLatitude)
            let pin = TrushAnnotation(coordinate: CLLocationCoordinate2D(latitude: garbage.trushLatitude,longitude:garbage.trushLongtitude),title:String(garbage.id), subtitle:String(garbage.isEmptyCan),titleVisibility:false,subtitleVisibility:false)
                                     
           
            mapKitView.addAnnotation(pin)
            
            print("set")
        }
        
    }
    func readGarbages()->Results<Garbage>{
        return realm.objects(Garbage.self)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var annotationView: MKAnnotationView!
        if annotationView == nil {
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        // pinに表示する画像を指定
        annotationView.image = UIImage(named: "brown_trush")!
        annotationView.annotation = annotation
        annotationView.canShowCallout = true
        return annotationView
    }
   
   
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        let annotation = view.annotation
        numberTitle = annotation?.title ?? ""
        self.performSegue(withIdentifier: "toSavedTrush", sender: nil)
    }
    // 位置情報を取得した場合
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                print("location: \(location)") // CLLocationManagerクラスで取得した位置情報
                print("緯度: \(location.coordinate.latitude)")
                print("経度: \(location.coordinate.longitude)")
                self.latitudeNow = Double(location.coordinate.latitude)
                self.longitudeNow = Double(location.coordinate.longitude)
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
               
                saveViewController.longitudeNow = longitudeNow
                saveViewController.latitudeNow = latitudeNow
            }else{
                print("NO")
            }
            if let sheet = next.sheetPresentationController {
                sheet.detents = [.medium()]
            }
        }
        if segue.identifier == "toSavedTrush"{
            let trushViewController = segue.destination as! TrushViewController
            trushViewController.number = Int(numberTitle) ?? 0
            if let sheet = next.sheetPresentationController {
                sheet.detents = [.medium()]
            }
        }
    }
    
}

