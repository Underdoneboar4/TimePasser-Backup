//
//  AnnouncementsModel.swift
//  placesCollection
//
//  Created by 90301207 on 12/7/18.
//  Copyright © 2018 90301207. All rights reserved.
//

import Foundation

class AnnouncementsModel: NSObject {
    
    //properties
    
    var title: String?
    var category: String?
    var content: String?
    var id: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(title: String, category: String, content: String, id: String) {
        
        self.title = title
        self.category = category
        self.content = content
        self.id = id
    }
    
    
    //prints object's current state
    /*
     override var description: String {
     return "Name: \(name), Address: \(address), Latitude: \(latitude), Longitude: \(longitude)"
     
     }
     */
    
    
}
