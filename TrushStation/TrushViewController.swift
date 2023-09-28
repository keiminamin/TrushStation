//
//  TrushViewController.swift
//  TrushStation
//
//  Created by 長島啓太朗 on 2023/09/26.
//

import UIKit
import RealmSwift
import CoreLocation
import MapKit
class TrushViewController: UIViewController {
    @IBOutlet var positionLabel:UILabel!
    @IBOutlet var fireButton:UIImageView!
    @IBOutlet var notFireButton:UIImageView!
    @IBOutlet var petButton:UIImageView!
    @IBOutlet var canButton:UIImageView!
    @IBOutlet var countLabel:UILabel!
    var number:Int!
    var latitudeNow:Double!
    var longitudeNow:Double!
    var garbages:Results<Garbage>!
    var targetgarbage:Garbage!
    var count:Int!
    var annotation:MKAnnotation!
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        garbages = readGarbages()
        latitudeNow = garbages[0].trushLatitude
        longitudeNow = garbages[0].trushLongtitude
        fireButton.isHidden = true
        notFireButton.isHidden = true
        petButton.isHidden = true
        canButton.isHidden = true
        if garbages[0].isBurnableGarbage{
            fireButton.isHidden = false
        }
        if garbages[0].isIncombustibleGarbage{
            notFireButton.isHidden = false
        }
        if garbages[0].isPetBottle{
            petButton.isHidden = false
        }
        if garbages[0].isEmptyCan{
            canButton.isHidden = false
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
    @IBAction func alert(){
        let alert: UIAlertController = UIAlertController(title: "削除", message: "ゴミ箱を本当に削除しますか", preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "はい",
                          style: .destructive,
                          handler: { [self]action in
                             
                              if let controller = self.presentingViewController as? MapViewController {
                                  try! self.realm.write{
                                      realm.delete(garbages[0])
                                  }
                                  controller.mapKitView.removeAnnotation(annotation)
                                  print("delete")
                                  
                                  controller.garbages = controller.readGarbages()
                                  controller.helloworld()
                                  controller.setTrushBox()
                            
                                 
                              }
                              self.dismiss(animated: true,completion: nil)
                          })
        )
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func suteru(){
        count = garbages[0].number + 1
        try! realm.write{
            garbages[0].number = count
        }
        
        garbages = readGarbages()
        countLabel.text = String(garbages[0].number)+"回"
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
