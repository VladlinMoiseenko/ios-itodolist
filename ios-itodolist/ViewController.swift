//
//  ViewController.swift
//  ios-itodolist
//
//  Created by Admin on 07.02.2019.
//  Copyright © 2019 Vladlin Moiseenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonClicked(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

