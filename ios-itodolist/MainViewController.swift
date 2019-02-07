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
        initInjections()
        bindObservables()
        mainViewModel?.fetchFirstData()
    }
    
    private func bindObservables() {
        _ = mainViewModel?.title.asObservable().bind(to: tLabel.rx.text)
    }
    
    private func initInjections() {
        mainViewModel = SwinjectStoryboard.getContainer().resolve(MainViewModel.self)
    }


}
