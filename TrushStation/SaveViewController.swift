//
//  SaveViewController.swift
//  TrushStation
//
//  Created by 長島啓太朗 on 2023/09/25.
//

import UIKit
import MapKit
class SaveViewController: UIViewController {
    @IBOutlet var positionLabel:UILabel!
    var longitudeNow: Double!
    var latitudeNow: Double!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let location = CLLocation(latitude: longitudeNow, longitude: latitudeNow)
        print("OK")
      
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.last, error == nil else { return }
            print(placemark.name)
            self.positionLabel.text = placemark.name
            // あとは煮るなり焼くなり
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
