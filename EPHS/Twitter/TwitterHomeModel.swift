//
//  TwitterHomeModel.swift
//  EPHS
//
//  Created by Jennifer Nelson on 12/19/18.
//  Copyright © 2018 EPHS. All rights reserved.
//
import Foundation

protocol TwitterHomeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class TwitterHomeModel: NSObject {
    
    /*
     This thing extracts the data from the php file into a json file.
     Then parseJSON() will read the json file and create TwitterInfoModel objects that
     contains items from the database.
     */
    
    
    weak var delegate: TwitterHomeModelProtocol!
    
    var data = Data()
    
    let urlPath: String = "http://athena.edenpr.org/~chauphana/twitter.php"
    
    func downloadItems() {
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error)
            in
            if error != nil {
                print("Failed to download data")
            } else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        var jsonElement = NSDictionary()
        let twitterDataArray = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let twitterData = TwitterInfoModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let username = jsonElement["username"] as? String               // let id = jsonElement["ID"] as? Int
            {
                //print("name\(username)")
                twitterData.username = username
                //  location.id = id
            }
            
            
            if let name = jsonElement["name"] as? String {
                twitterData.name = name
            }
            
            if let department = jsonElement["department"] as? String {
                twitterData.department = department
            }
            twitterDataArray.add(twitterData)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: twitterDataArray)
            
        })
    }
    
}
