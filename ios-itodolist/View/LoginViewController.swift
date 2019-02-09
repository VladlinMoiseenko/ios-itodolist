//
//  ViewController.swift
//  ios-itodolist
//
//  Created by Admin on 07.02.2019.
//  Copyright © 2019 Vladlin Moiseenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Swinject
import SwinjectStoryboard

class ViewController: UIViewController {

    @IBAction func buttonClicked(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    var loginViewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initInjections()
        bindObservables()
        //loginViewModel?.fetchFirstData()
    }

    private func bindObservables() {
        //_ = loginViewModel?.title.asObservable().bind(to: tLabel.rx.text)
    }
    
    private func initInjections() {
        loginViewModel = SwinjectStoryboard.getContainer().resolve(LoginViewModel.self)
    }

}

