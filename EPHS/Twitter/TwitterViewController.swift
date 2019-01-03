//
//  TwitterViewController.swift
//  EPHS
//
//  Created by Jennifer Nelson on 12/19/18.
//  Copyright © 2018 EPHS. All rights reserved.
//

import UIKit

class TwitterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TwitterHomeModelProtocol  {
    
    //Properties
    //This will be the array that is filled through the database
    var feedItems: NSArray = NSArray()
    
    //This will be the selected profile the user taps on in the tableview
    var selectedProfile : TwitterInfoModel = TwitterInfoModel()
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegates and initialize homeModel
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let twitterHomeModel = TwitterHomeModel()
        twitterHomeModel.delegate = self
        twitterHomeModel.downloadItems()
        
    }
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        self.listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        //Each TableViewCell is of the custom ViewControllerTableViewCell type created
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TwitterViewControllerTableViewCell
        //Get the Twitter Model created to store values from the database
        let item: TwitterInfoModel = feedItems[indexPath.row] as! TwitterInfoModel
        // Get references to labels of cell
        
        cell.teacherName.text = item.name!
        cell.department.text = item.department!
        
        //Makes the images round
        cell.cellImage.layer.cornerRadius = CGFloat(cell.cellImage.frame.size.width) / 2.0
        cell.cellImage.clipsToBounds = true
        
        //Actually get the images for the current cell by sending the cell and item
        getImage(username: item.username!, cell: cell, item: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Set selected location to va
        print("here")
        selectedProfile = feedItems[indexPath.row] as! TwitterInfoModel
        print("\(selectedProfile.username)")
        // Manually call segue to detail view controller
        self.performSegue(withIdentifier: "twitterSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get reference to the destination view controller
        //Sets the Destination ViewController
        //And sets up the variables of that ViewController's
        
        let webVC  = segue.destination as! TwitterWebViewController
        
        webVC.url = "https://twitter.com/\(selectedProfile.username!)"
        
        
    }
    
    
    /*
     Job of this function is to load an image from a URL
     source https://www.simplifiedios.net/get-image-from-url-swift-3-tutorial/
     */
    
    func getImage(username: String, cell: TwitterViewControllerTableViewCell, item: TwitterInfoModel) {
        //build imageURL from username https://avatars.io/twitter/\(username)
        let URL_IMAGE = "https://avatars.io/twitter/\(username)"
        //sets a default image so the image space is declared
        var image: UIImage = UIImage(named: "asteroid2")!
        
        //create datatask
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: URL_IMAGE)!) as URLRequest) { (data, response, error) in
            //print("task is running")
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
                
            } else {
                //in case of now error, checking wheather the response is nil or not
                if (response as? HTTPURLResponse) != nil {
                    //checking if the response contains an image
                    if let imageData = data {
                        if imageData != nil {
                            image = UIImage(data: imageData)!
                            //creates a queue request on the main thread to execute code from
                            //excuting this code on this second task thread will not work
                            DispatchQueue.main.sync(execute: {
                                cell.cellImage.image = image
                            })
                        }
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        //This line actually starts the task to find the image
        task.resume()
    }
    
}


