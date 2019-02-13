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
    
    @IBOutlet var tLabel: UILabel!
    
    let res = Variable<String>("")
    
    let loginButton = UIButton(type: .roundedRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initInjections()
        //bindObservables()
        progressView.isHidden = true
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor.white
        loginButton.frame = CGRect(x: 20, y: 200, width: 200, height: 40)
        view.addSubview(loginButton)
        
        
        //loginButton.rx_action = loginViewModel?.buttonAction
        
        
        //loginButton.rx.bind(action) { _ in return "Hello"}
        
//        let button1 = UIButton()
//        let button2 = UIButton()
//        
//        let action = Action<String, String> { input in
//            print(input)
//            return .just(input)
//        }
//        button1.rx.bind(action) {"Hello"}
//        button2.rx.bind(action) { _ in return "Goodbye"}
//        
        
    }

//    let action = Action<String, String> { input in
//        print(input)
//        return .just(input)
//    }
    
//    private func bindObservables() {
        //loginButton.rx.bind(action) { _ in return "Hello"}
        //loginButton.rx.action = loginViewModel?.loginAction
        //_ = loginViewModel?.title.asObservable().bind(to: tLabel.rx.text)
        //        _ = loginViewModel?.title.asObservable().bind(to: res)
        //        print(res)
//    }
    
    
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
    


    func doLogin(_ username:String, _ password:String) {

        UserDefaults.standard.set("empty", forKey: "accessToken")
        
        loginViewModel?.apiAuthorize(username, password)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: "updateProgressView", userInfo: nil, repeats: true)
        progressView.setProgress(0, animated: true)
        progressView.progressViewStyle = UIProgressViewStyle.default
        progressView.isHidden = false
        
        
//            if UserDefaults.standard.string(forKey: "accessToken") != "empty" {
//                let vc = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//            } else {
//                let alert = UIAlertController(title: "Username or Password incorrect", message: "Please re-type username or password.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                self.present(alert, animated: true)
//            }
    
    }
    
    func updateProgressView() {
        if progressView.progress != 1 {
            self.progressView.progress += 2/10
        }
    }
    
    private func initInjections() {
        loginViewModel = SwinjectStoryboard.getContainer().resolve(LoginViewModel.self)
    }

}

