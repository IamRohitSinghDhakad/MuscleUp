//
//  SubscriptionViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit

class SubscriptionViewController: UIViewController {

    @IBOutlet var cvSuscription: UICollectionView!
    @IBOutlet var pageController: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cvSuscription.delegate = self
        self.cvSuscription.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.setBgColor()
    }
    
    
   
    
    @IBAction func btnOpenSideMenu(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
    
  
}

extension SubscriptionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubscriptionCollectionViewCell", for: indexPath)as! SubscriptionCollectionViewCell
        
        
        cell.tblSubscriptionList.reloadData()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let noOfCellsInRow = 1

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            let sizeHeight = Int((collectionView.bounds.height - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: sizeHeight)
    }
    
    
}
