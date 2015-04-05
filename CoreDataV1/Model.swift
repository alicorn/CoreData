//
//  Model.swift
//  CoreDataTest
//
//  Created by alicorn on 4/4/15.
//  Copyright (c) 2015 pegasus studios. All rights reserved.
//

import UIKit
import CoreData

@objc(Model)

class Model: NSManagedObject {
    
    //merge the atribute from coreData
    
    @NSManaged var info: String
    @NSManaged var item: String
    @NSManaged var quantity: String
    
    
}
