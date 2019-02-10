//
//  MainViewModel.swift
//  ios-itodolist
//
//  Created by Admin on 07.02.2019.
//  Copyright © 2019 Vladlin Moiseenko. All rights reserved.
//

import RxSwift
import RxCocoa

class MainViewModel {
    
    let apiController: ApiController
    
    let title = Variable<String>("")
    
    private var model: TaskModel {
        willSet {
            title.value = "[TITLE FO:]\(newValue.title)"
        }
    }
    
    init(apiController: ApiController) {
        self.apiController = apiController
        self.model = TaskModel()
    }
    
    func fetchFirstData() {
        apiController.getFirstData(success: { model in
            self.model = model
        }, failure: { errorMsg in
            print(errorMsg)
        })
    }
}
