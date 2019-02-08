//
//  MainViewController.swift
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

class MainViewController: UIViewController {

    @IBOutlet weak var tLabel: UILabel!
    
    var mainViewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        initInjections()
        bindObservables()
        mainViewModel?.fetchFirstData()
    }
    
    private func setupNavigationBarItems() {
        let titleImageView = UIImageView(image: UIImage(named: "title_icon@2x.png")!)
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
                
        let exitButton = UIButton(type: .system)
        exitButton.setTitle("Exit", for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: exitButton)
    }
    
    
    private func bindObservables() {
        _ = mainViewModel?.title.asObservable().bind(to: tLabel.rx.text)
    }
    
    private func initInjections() {
        mainViewModel = SwinjectStoryboard.getContainer().resolve(MainViewModel.self)
    }


}
