//
//  FoodDescriptionVC.swift
//  GooglePlacesClone
//
//  Created by Liam Khong on 4/28/18.
//  Copyright © 2018 Vishal. All rights reserved.
//

import UIKit

class FoodDescriptionVC: UIViewController {

    @IBOutlet weak var txtDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtDescription.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donePressed(_ sender: Any) {
        if (txtDescription.text.count > 0) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.foodDescription = txtDescription.text
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
