//
//  CastVC.swift
//  EpicAssignmentWithUiKit
//
//  Created by Himash Nadeeshan on 2021-11-10.
//

import UIKit

class CastVC: UIViewController {
    
    //MARK: outlets
    @IBOutlet weak var tabsCollectionView: UICollectionView!
    @IBOutlet weak var bottomTabBarBgView: UIView!
    @IBOutlet weak var bgviewForTopImg: UIView!
    @IBOutlet weak var castSliderCollectionView: UICollectionView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBarBGView: UIView!
    @IBOutlet weak var pageCountLbl: UILabel!
    @IBOutlet weak var progressBarWidth: NSLayoutConstraint!
    @IBOutlet weak var pageCountBgView: UIView!
    
    //MARK: Variables
    let vm = CastVM()
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.setUpCollectionView()
        self.getCastInfo()
        
    }
}

//MARK:- Funcs For UI
extension CastVC{
    func setupUI(){
        
        //Top img background view
        bgviewForTopImg.layer.cornerRadius = bgviewForTopImg.layer.frame.height / 2
        
        //Hiiden progress till request done
        pageCountBgView.isHidden = true
        
        // set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
                activityIndicator.color = UIColor.white
        self.view.addSubview(activityIndicator)
    }
    
    //After API Call
    func configUIAfterAPICall(){
        DispatchQueue.main.async {
            self.castSliderCollectionView.reloadData()
        }
        self.progressBarWidth.constant = self.progressBarBGView.frame.width / CGFloat(self.vm.castList.count)
        self.pageCountBgView.isHidden = false
        if vm.castList.count > 0{
            self.pageCountLbl.text = "1 / \(vm.castList.count)"
        }
    }
    
}

//MARK:- Collectionviews
extension CastVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //Setup delegates & datascource
    func setUpCollectionView() {
        //Tabs
        tabsCollectionView.dataSource = self
        tabsCollectionView.delegate = self
        
        //Cast
        castSliderCollectionView.dataSource = self
        castSliderCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == tabsCollectionView ? vm.tabItems.count : vm.castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tabsCollectionView{
            //Tabs
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabsCVC", for: indexPath) as! TabsCVC
            cell.configCell(title: vm.tabItems[indexPath.row])
            return cell
        }else{
            //Cast
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCVC", for: indexPath) as! CastCVC
            cell.configCell(cast: vm.castList[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == castSliderCollectionView{
            let height = (self.view.frame.size.height)
            let width = self.view.frame.size.width
            //Cast
            return CGSize(width: width * 0.6, height: height - 330)
        }else{
            //Tabs
            return CGSize(width: 0, height: 0)
        }
    }

}

//MARK:- Paging count
extension CastVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0{
            pageCountLbl.text = "\(String(format: "%.0f", round((scrollView.contentOffset.x / (self.view.frame.size.width * 0.6)) + 1))) / \(self.vm.castList.count)"
            progressBarWidth.constant = (progressBarBGView.frame.width / CGFloat(self.vm.castList.count)) * (round(scrollView.contentOffset.x / (self.view.frame.size.width * 0.6)) + 1)
        }
    }
}

//MARK:- API Call
extension CastVC{
    func getCastInfo(){
        self.activityIndicator.startAnimating()
        self.vm.getCastList(limit: 5) { (status, message) in
            self.activityIndicator.stopAnimating()
            if status{
                //Success
                print(message)
                self.configUIAfterAPICall()
            }else{
                //Error handle in view
                print(message)
            }
        }
    }
}
