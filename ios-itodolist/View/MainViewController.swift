import UIKit
import RxSwift
import RxCocoa
import Swinject
import SwinjectStoryboard

class MainViewController: UIViewController {
 
    var mainViewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        initInjections()
        bindObservables()
        mainViewModel?.fetchTasksData()
    }
    
    private func setupNavigationBarItems() {
        
        navigationItem.hidesBackButton = true
        
        let titleLabel = UILabel()
        titleLabel.text = "Tasks"
        navigationItem.titleView = titleLabel
        
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutButton)
    }
    
    func logoutButtonAction() {
        print("Logout is tapped")
    }
    
    private func bindObservables() {
        //_ = mainViewModel?.title.asObservable().bind(to: tLabel.rx.text)
    }
    
    private func initInjections() {
        mainViewModel = SwinjectStoryboard.getContainer().resolve(MainViewModel.self)
    }


}
