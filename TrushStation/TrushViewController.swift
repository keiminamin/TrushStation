//
//  TrushViewController.swift
//  TrushStation
//
//  Created by 長島啓太朗 on 2023/09/26.
//

import UIKit
import RealmSwift
import CoreLocation
class TrushViewController: UIViewController {
    @IBOutlet var positionLabel:UILabel!
    @IBOutlet var fireButton:UIImageView!
    @IBOutlet var notFireButton:UIImageView!
    @IBOutlet var petButton:UIImageView!
    @IBOutlet var canButton:UIImageView!
    var number:Int!
    var latitudeNow:Double!
    var longitudeNow:Double!
    var garbages:Results<Garbage>!
    
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        garbages = readGarbages()
        latitudeNow = garbages[0].trushLatitude
        longitudeNow = garbages[0].trushLongtitude
        if garbages[0].isBurnableGarbage{
            fireButton.isHidden = true
        }
        if garbages[0].isIncombustibleGarbage{
            notFireButton.isHidden = true
        }
        if garbages[0].isPetBottle{
            petButton.isHidden = true
        }
        if garbages[0].isEmptyCan{
            canButton.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
      
        let location = CLLocation(latitude: latitudeNow, longitude: longitudeNow)
        print("OK")
      
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.last, error == nil else { return }
            self.positionLabel.text = placemark.name
            // あとは煮るなり焼くなり
        }
    }
    func readGarbages()->Results<Garbage>{
        return realm.objects(Garbage.self).filter("id==%@",number ?? 0)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
