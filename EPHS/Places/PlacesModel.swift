//
//  LocationModel.swift
//  EPHS
//
//  Created by Jennifer Nelson on 12/19/18.
//  Copyright © 2018 EPHS. All rights reserved.
//

import Foundation

class PlacesModel: NSObject {
    
    //properties
    
    var name: String?
    var subtitle: String?
    var information: String?
    var directions: String?
    var id: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(name: String, subtitle: String, information: String, directions: String, id: String) {
        
        self.name = name
        self.subtitle = subtitle
        self.information = information
        self.directions = directions
        self.id = id
        
    }
    
    
    //prints object's current state
    /*
     override var description: String {
     return "Name: \(name), Address: \(address), Latitude: \(latitude), Longitude: \(longitude)"
     
     }
     */
    
    
}

