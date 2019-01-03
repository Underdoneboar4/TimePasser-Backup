//
//  TwitterInfoModel.swift
//  EPHS
//
//  Created by Jennifer Nelson on 12/19/18.
//  Copyright © 2018 EPHS. All rights reserved.
//

import UIKit

class TwitterInfoModel: NSObject {
    
    /*
     This is the model object that HomeModel uses to construct objects that contain
     items from the database row
     */
    
    var username: String?
    var name: String?
    var id: String?
    var department: String?
    
    override init()
    {
        //blank default constructor
    }
    
    //construct object with parameters
    //never used i think
    init(username: String, id: String) {
        self.id = id
        self.username = username
        
    }
    
    
    
    
}

