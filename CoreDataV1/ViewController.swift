//
//  ViewController.swift
//  CoreDataV1
//
//  Created by alicorn on 4/6/15.
//  Copyright (c) 2015 pegasus studios. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {


    
    @IBOutlet weak var latitudelabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var manager = CLLocationManager()
    var geocoder = CLGeocoder()
    var placseMark = CLPlacemark()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.requestAlwaysAuthorization()

        // Do any additional setup after loading the view.
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: \(error.localizedDescription)")
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("New Location: \(manager.location)")
        
        let currentLocation = manager.location
        
        if currentLocation != nil{
            latitudelabel.text = "\(currentLocation.coordinate.latitude)"
            longitudeLabel.text = "\(currentLocation.coordinate.longitude)"
            
            geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            placsemarks, error in
                
                if error != nil && placsemarks.count > 0{
                    self.placseMark = (placsemarks.last as? CLPlacemark)!
                    self.adressLabel.text = "\(self.placseMark.country)"
                    self.manager.stopUpdatingLocation()
                    self.button.enabled = true
                }
            
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonPressed(sender: AnyObject) {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        button.enabled = false
    }


}
