//
//  PlacesViewController.swift
//  EPHS
//
//  Created by Jennifer Nelson on 12/19/18.
//  Copyright © 2018 EPHS. All rights reserved.
// homeModel = PlacesHomeModel
// LocationModel = PlacesModel




//
import UIKit

class PlacesViewController: UIViewController,
UICollectionViewDelegate, UICollectionViewDataSource, PlacesHomeModelProtocol{
   
    var feedItems: NSArray = NSArray()
    var selectedLocation: PlacesModel = PlacesModel()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let width = collectionView.frame.size.width - 20
        let height = width / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let placesHomeModel = PlacesHomeModel()
        placesHomeModel.delegate = self
        placesHomeModel.downloadItems()
    }
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier: String = "basicCell"
        let myCell: myCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! myCollectionViewCell
        let item: PlacesModel = feedItems[indexPath.row] as! PlacesModel
        myCell.locationLabel.text = item.name
        if let theImage = item.id {
            myCell.locationImageView.image = UIImage(named: theImage)
            myCell.locationImageView.layer.cornerRadius = myCell.locationImageView.frame.size.width / 2
            myCell.locationImageView.clipsToBounds = true
        }
        myCell.locationSubtitleLabel.text = item.subtitle
        return myCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionView 1")
        selectedLocation = feedItems[indexPath.row] as! PlacesModel
        performSegue(withIdentifier: "placesSegue", sender: self)
        print("collectionView 2")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare 1")
        
        
        let detailVC = segue.destination as! PlacesDetailViewController
        detailVC.selectedLocation = selectedLocation
        print("prepare 2")
    }
    
    
    
    
}

