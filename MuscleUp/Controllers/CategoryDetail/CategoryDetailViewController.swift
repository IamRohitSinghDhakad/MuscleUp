//
//  CategoryDetailViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit
import AVFoundation
import SDWebImage
import AVKit

class CategoryDetailViewController: UIViewController {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgVwVideo: UIImageView!
    @IBOutlet var lblTitleText: UILabel!
    @IBOutlet var txtVwDesc: UITextView!
    

    var obj = CategoryModel(dict: [:])
    
    var player: AVPlayer!
    var playerViewController: AVPlayerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblTitle.text = obj.strCategory_name
        
        if objAppShareData.UserDetail.strGender == "Male"{
            self.lblTitleText.text = "\(obj.strCategory_name) exercise for men"
        }else{
            self.lblTitleText.text = "\(obj.strCategory_name) exercise for women"
        }
        
        let profilePic = obj.strCategory_image
        if profilePic != "" {
            let url = URL(string: profilePic)
            self.imgVwVideo.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"))
           
        }
        self.txtVwDesc.text = obj.strDesription
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.setBgColor()
    }
    
    
    //MARK: - Setup
    func setupView() {
        let videoUrl = self.obj.strCategory_video
            if videoUrl != "" {
                guard let url = URL(string: videoUrl) else {
                    return
                }
                // Create an AVPlayer, passing it the HTTP Live Streaming URL.
                self.player = AVPlayer(url: url)
                self.playerViewController = AVPlayerViewController()
                self.playerViewController.player = player
                present(self.playerViewController, animated: true) {
                    self.player.play()
                }
            }
            else {
                
            }
            
        
    }
    
    

    @IBAction func btnOnPlayMedia(_ sender: Any) {
        self.setupView()
    }
    

    @IBAction func btnBackOnHeader(_ sender: Any) {
        self.onBackPressed()
    }
}
