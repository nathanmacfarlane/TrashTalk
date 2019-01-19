//
//  ImageViewController.swift
//  TrashTalk
//
//  Created by Patrick Beninga on 1/19/19.
//  Copyright © 2019 Nathan Macfarlane. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIGestureRecognizerDelegate{
    var imgView = UIImageView(frame:CGRect.zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.frame = self.view.frame
        self.view.addSubview(imgView)
        let tgr = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.view.addGestureRecognizer(tgr)
        // Do any additional setup after loading the view.
    }
    @objc func tap(tap:UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil) 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
