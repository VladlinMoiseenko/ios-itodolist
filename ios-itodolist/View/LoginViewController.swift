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
    @IBOutlet var progressView: UIProgressView!
    
    var loginViewModel: LoginViewModel?
    
    //let status = Variable<Int>(0)

    override func viewDidLoad() {
        super.viewDidLoad()
        initInjections()
        //bindObservables()
        progressView.isHidden = true
        
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
    
    //private func bindObservables() {
        //_ = loginViewModel?.status.asObservable().bind(to: status)
    //}

    func doLogin(_ username:String, _ password:String) {

        UserDefaults.standard.set("empty", forKey: "authorizationCode")
        
        loginViewModel?.apiAuthorize(username, password)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: "updateProgressView", userInfo: nil, repeats: true)
        progressView.setProgress(0, animated: true)
        progressView.isHidden = false
        progressView.progressViewStyle = UIProgressViewStyle.bar
        
//        if (UserDefaults.standard.string(forKey: "authorizationCode") == "empty") {
//           print("empty")
//        } else {
//           print("ac", UserDefaults.standard.string(forKey: "authorizationCode"))
//        }
        
//        let res = loginViewModel?.apiAuthorize(username, password)
//        
//        if (res == true) {
//            let vc = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else {
//            let alert = UIAlertController(title: "Username or Password incorrect", message: "Please re-type username or password.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true)
//        }
    }
    
    func updateProgressView() {
        if progressView.progress >= 1 {
            progressView.isHidden = true
            //print("ac", UserDefaults.standard.string(forKey: "authorizationCode"))
        } else {
            self.progressView.progress += 2/10
        }
    }
    
    private func initInjections() {
        loginViewModel = SwinjectStoryboard.getContainer().resolve(LoginViewModel.self)
    }

}

