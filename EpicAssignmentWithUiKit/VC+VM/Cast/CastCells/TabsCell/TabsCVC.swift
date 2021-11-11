//
//  TabsCVC.swift
//  EpicAssignmentWithUiKit
//
//  Created by Himash Nadeeshan on 2021-11-10.
//

import UIKit

class TabsCVC: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        setupUI()
    }
    
    func setupUI(){
        //Charachter spacing
        titleLbl.setTextSpacingBy(value: 1.0)
    }
    
    //Setup data
    func configCell(title: String){
        titleLbl.text = title
    }
    
}
