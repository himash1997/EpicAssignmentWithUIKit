//
//  CastCVC.swift
//  EpicAssignmentWithUiKit
//
//  Created by Himash Nadeeshan on 2021-11-10.
//

import UIKit
import SDWebImage

class CastCVC: UICollectionViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var castImg: UIImageView!
    @IBOutlet weak var imgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var linkBtn: UIButton!
    @IBOutlet weak var occupationsCollectionView: UICollectionView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    //MARK: Variables
    var vm = CastCVCVM()
    
    //MARK:- LifeCycle
    override func awakeFromNib() {
        setupUI()
        setUpCollectionView()
    }
    
    //MARK:- Setu UI
    func setupUI(){
        linkBtn.layer.cornerRadius = linkBtn.frame.height / 2
        cellBackgroundView.layer.cornerRadius = 20
        self.imgViewHeight.constant = self.cellBackgroundView.bounds.height * 0.65
        
        //Image corners round
        DispatchQueue.main.async {
            self.castImg.roundCorners(corners: [.topLeft, .topRight], radius: 20)
            self.castImg.layer.masksToBounds = true
        }
    }
    
    //MARK:- Config cell with data
    func configCell(cast: Cast){
        nameLbl.text = cast.name
        vm.occupations = cast.occupation
        occupationsCollectionView.reloadData()
        castImg.sd_setImage(with: URL(string: cast.img), placeholderImage: UIImage(named: "sample"))
    }
}

//MARK:- Occupation Collectionview
extension CastCVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //Setup delegates & datascource
    func setUpCollectionView() {
        occupationsCollectionView.dataSource = self
        occupationsCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vm.occupations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OccupationCVC", for: indexPath) as! OccupationCVC
        cell.cellConfig(name: vm.occupations[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
    }
    
}

