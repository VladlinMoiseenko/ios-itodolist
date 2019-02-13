import UIKit
import RxSwift
import RxCocoa
import Swinject
import SwinjectStoryboard

class ViewController: UIViewController {

    @IBOutlet var _username: UITextField!
    @IBOutlet var _password: UITextField!
    @IBOutlet var _login_button: UIButton!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    var loginViewModel: LoginViewModel?
    
    var disposeBag = DisposeBag()
    
    var label = UITextField(frame: CGRect(x: 20, y: 200, width: 200, height: 40))
    
    var timer = Timer()
    
    func textFieldDidChange(_ label: UITextField) {
            print(9)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initInjections()

        //label.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        label.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
        
        view.addSubview(label)
        
        _ = loginViewModel?.title.asObservable().bind(to: label.rx.text)
        
//        label.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
//        func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//            if keyPath == "text" {
//                print("old:", change?[.oldKey])
//                print("new:", change?[.newKey])
//            }
//        }
        
//        loginButton.rx.tap
//            .subscribe({ _ in
//                    self.res = "fofo"
//                }
//            ).disposed(by: disposeBag)
        
    }
    
//    init(apiController: ApiController) {
//        self.apiController = apiController
//        self.modelAccesstoken = Accesstoken()
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
    
    func timerAction() {
        //print("action has started")
        print(":", UserDefaults.standard.string(forKey: "accessToken"))
        
        
//        "be5338ba055bbceb378af03cf9571141"
//        "fb03922a5b06a94625279b5577fadb19"
        
    }
    
    
    func doLogin(_ username:String, _ password:String) {
        
        self.indicatorView.startAnimating()
        
        self._login_button.isEnabled = false
        
        UserDefaults.standard.set("empty", forKey: "accessToken")
        
        loginViewModel?.apiAuthorize(username, password)
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
        

        
//            if UserDefaults.standard.string(forKey: "accessToken") != "empty" {
//                let vc = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//            } else {
//                let alert = UIAlertController(title: "Username or Password incorrect", message: "Please re-type username or password.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                self.present(alert, animated: true)
//            }
    
    }
    

    
    private func initInjections() {
        loginViewModel = SwinjectStoryboard.getContainer().resolve(LoginViewModel.self)
    }

}

