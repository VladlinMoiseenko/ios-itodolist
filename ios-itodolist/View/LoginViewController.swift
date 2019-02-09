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

    @IBOutlet var _username: UITextField!
    @IBOutlet var _password: UITextField!
    @IBOutlet var _login_button: UIButton!
    
    var loginViewModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        initInjections()
        bindObservables()
        //loginViewModel?.fetchFirstData()
    }

    @IBAction func LoginButton(_ sender: Any) {
        
        let username = _username.text
        let password = _password.text
        
        if (username == "") {
            let alert = UIAlertController(title: "Username is empty", message: "Please type username.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }

        if (password == "") {
            let alert = UIAlertController(title: "Password is empty", message: "Please type password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        doLogin(username!, password!)
        
    }
    
    func doLogin(_ user:String, _ pass:String) {
        // authorize REST
        
        
        
        
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
//        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    private func bindObservables() {
        //_ = loginViewModel?.title.asObservable().bind(to: tLabel.rx.text)
    }
    
    private func initInjections() {
        loginViewModel = SwinjectStoryboard.getContainer().resolve(LoginViewModel.self)
    }

}

