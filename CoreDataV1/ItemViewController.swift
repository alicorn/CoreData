 //
 //  ItemViewController.swift
 //  CoreDataTest
 //
 //  Created by alicorn on 4/4/15.
 //  Copyright (c) 2015 pegasus studios. All rights reserved.
 //
 
 import UIKit
 import CoreData
 import CoreLocation
 
 class ItemViewController: UIViewController, CLLocationManagerDelegate {
 
    @IBOutlet weak var item : UITextField! = nil
    @IBOutlet weak var quantity : UITextField! = nil
    @IBOutlet weak var info : UITextField! = nil
    @IBOutlet weak var land: UITextField! = nil
   
    var itemtext: String = ""
    var quantitytext: String = ""
    var infotext: String = ""
    var landtext: String = ""

    @IBOutlet weak var button: UIButton!
 
    var manager = CLLocationManager()
    var geocoder = CLGeocoder()
    var placeMark: CLPlacemark?
   
    var existingItem: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        manager.requestAlwaysAuthorization()
        
        if (existingItem != nil) {
            item.text = itemtext
            quantity.text = quantitytext
            info.text = infotext
            land.text = landtext
        }
       
    }
   

    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("ERROR: \(error.localizedDescription)")
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("new Location: \(manager.location)")
        
        let currentLocation = manager.location
        
        if currentLocation != nil {
            //latitudeLabel.text = "\(currentLocation.coordinate.latitude)"
            //longitudeLabel.text = "\(currentLocation.coordinate.longitude)"
            
            geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
                placemarks, error in
                
                if error == nil && placemarks.count > 0 {
                    self.placeMark = placemarks.last as? CLPlacemark
                    
                    self.quantity.text = "\(self.placeMark!.thoroughfare)"
                    self.info.text = "\(self.placeMark!.postalCode) \(self.placeMark!.locality)"
                    self.land.text = "\(self.placeMark!.country)"
                    
                    self.manager.stopUpdatingLocation()
                    self.button.enabled = true
                }
            })
        }
    }
    
    
    @IBAction func save(sender: AnyObject) {
        
        // reference to our app delegate
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Reference to our model
        
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entityForName("List", inManagedObjectContext: context)
        
        // check the Item are exists
        if  (existingItem != nil) {
            
            existingItem.setValue(item.text as String, forKey: "item")
            existingItem.setValue(quantity.text as String, forKey: "quantity")
            existingItem.setValue(info.text as String, forKey: "info")
            existingItem.setValue(land.text as String, forKey: "land")
            println("true")
            
        }else{
            
            // create instance of pur data model and initialize
            var newItem = Model(entity: en!, insertIntoManagedObjectContext: context)
            
            // map our properties
            newItem.info = info.text
            newItem.item = item.text
            newItem.quantity = quantity.text
            newItem.land = land.text
            println("fale")
    
        }
        
        // create instance of pur data model and initialize
            //var newItem = Model(entity: en!, insertIntoManagedObjectContext: context)
        
        // map our properties
            //newItem.info = info.text
            //newItem.item = item.text
            //newItem.quantity = quantity.text
        
        // Save our context
        
        context.save(nil)
        
        // navigate back to root vc
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        //naviagte back to root
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button(sender: AnyObject) {


        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.startUpdatingLocation()
        button.enabled = false
        
    }
    
    
 }

 
 
 
 
 
 
 
 
 
 