//
//  FirstViewController.swift
//  EPHS
//
//  Created by Jennifer Nelson on 12/19/18.
//  Copyright © 2018 EPHS. All rights reserved.
//

import UIKit

class AnnouncementsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, HomeModelProtocol{
    
    var feedItems: NSArray = NSArray()
    var selectedLocation: AnnouncementsModel = AnnouncementsModel()
    @IBOutlet weak var announcementsTitleCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.announcementsTitleCV.delegate = self
        self.announcementsTitleCV.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
    }
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.announcementsTitleCV.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier: String = "announcementsFirstCell"
        let myCell: announcmentsCollectionViewCell = announcementsTitleCV.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! announcmentsCollectionViewCell
        let item: AnnouncementsModel = feedItems[indexPath.row] as! AnnouncementsModel
        myCell.firstLabel.text = item.title
        //  print (item.id)
        //  print(item.name)
        return myCell
        
    }
    
    
}
