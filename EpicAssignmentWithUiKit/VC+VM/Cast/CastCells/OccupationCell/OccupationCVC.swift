//
//  OccupationCVC.swift
//  EpicAssignmentWithUiKit
//
//  Created by Himash Nadeeshan on 2021-11-10.
//

import UIKit

class OccupationCVC: UICollectionViewCell {
    
    @IBOutlet weak var occupationtitle: UILabel!
    
    func cellConfig(name: String){
        occupationtitle.text = name
    }
}
