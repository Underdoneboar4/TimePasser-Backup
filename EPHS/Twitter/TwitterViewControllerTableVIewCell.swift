//
//  TwitterViewControllerTableVIewCell.swift
//  EPHS
//
//  Created by Jennifer Nelson on 12/19/18.
//  Copyright © 2018 EPHS. All rights reserved.
//

import UIKit

class TwitterViewControllerTableViewCell: UITableViewCell {
  
    
    @IBOutlet weak var cellImage: UIImageView!
    
     @IBOutlet weak var department: UILabel!
    /*
     This a custom class for a UITableViewCell used in this TableViewCell
     for every prototype cell.
     */
    
    @IBOutlet weak var teacherName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
