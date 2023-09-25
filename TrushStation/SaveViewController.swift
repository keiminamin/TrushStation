//
//  SaveViewController.swift
//  TrushStation
//
//  Created by 長島啓太朗 on 2023/09/25.
//

import UIKit
import MapKit
import RealmSwift
class SaveViewController: UIViewController {
    @IBOutlet var positionLabel:UILabel!
    @IBOutlet var fireButton:UIButton!
    @IBOutlet var notFireButton:UIButton!
    @IBOutlet var petButton:UIButton!
    @IBOutlet var canButton:UIButton!
    var saveData: UserDefaults = UserDefaults.standard
    var longitudeNow: Double!
    var latitudeNow: Double!
    var number:Int = 0
    let realm = try! Realm()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
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
    @IBAction func petTrue(){
        if petButton.isSelected{
            petButton.setImage(UIImage(named: "pet"), for: .normal)
         
            petButton.isSelected = false
        }else{
            petButton.setImage(UIImage(named: "green_pet"), for: .normal)
            petButton.imageView?.contentMode = .scaleAspectFill
          
            petButton.isSelected = true
        }
        
        print(petButton.isSelected)
    }
    @IBAction func fireTrue(){
        if fireButton.isSelected{
            fireButton.setImage(UIImage(named: "fire"), for: .normal)
            fireButton.isSelected = false
        }else{
            fireButton.setImage(UIImage(named: "green_fire"), for: .normal)
           
            fireButton.isSelected = true
        }
        
        print(fireButton.isSelected)
    }
    @IBAction func notFireTrue(){
        if notFireButton.isSelected{
            notFireButton.setImage(UIImage(named: "notfire"), for: .normal)
            notFireButton.isSelected = false
        }else{
            notFireButton.setImage(UIImage(named: "green_notfire"), for: .normal)
           
            notFireButton.isSelected = true
        }
        
        print(notFireButton.isSelected)
    }
    @IBAction func canTrue(){
        if canButton.isSelected{
            canButton.setImage(UIImage(named: "can"), for: .normal)
            canButton.isSelected = false
        }else{
            canButton.setImage(UIImage(named: "green_can"), for: .normal)
           
            canButton.isSelected = true
        }
        
        print(canButton.isSelected)
    }
    @IBAction func save(){
        let garbage = Garbage()
        number = saveData.integer(forKey: "number") ?? 0
        print(saveData.integer(forKey: "number"))
        garbage.trushLongtitude = longitudeNow
        garbage.trushLatitude = latitudeNow
        garbage.isBurnableGarbage = fireButton.isSelected
        garbage.isIncombustibleGarbage = notFireButton.isSelected
        garbage.isPetBottle = petButton.isSelected
        garbage.isEmptyCan = canButton.isSelected
        garbage.id = number
        number += 1
        saveData.set(number,forKey: "number")
        print("save")
        createGarbage(garbage: garbage)
        self.dismiss(animated: true)
    }
    func createGarbage(garbage: Garbage){
        try! realm.write{
            realm.add(garbage)
        }
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
