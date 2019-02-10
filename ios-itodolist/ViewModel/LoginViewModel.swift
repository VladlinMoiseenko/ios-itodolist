//
//  LoginViewModel.swift
//  ios-itodolist
//
//  Created by Admin on 07.02.2019.
//  Copyright © 2019 Vladlin Moiseenko. All rights reserved.
//

import RxSwift
import RxCocoa

class LoginViewModel {
    
    let apiController: ApiController
    
//    let title = Variable<String>("")

    private var model: Authorize {
        willSet {
//            title.value = "[TITLE FO:]\(newValue.title)"
        }
    }

    init(apiController: ApiController) {
        self.apiController = apiController
        self.model = Authorize()
    }

    func apiAuthorize(_ username:String, _ password:String) -> Bool {
        
        let jsonParam = try? JSONEncoder().encode(Credentials(username: username, password: password))
        let param = try? JSONSerialization.jsonObject(with: jsonParam!, options: []) as? [String : Any]

        apiController.authorize(param: param as! [String : Any], success: {model in
            self.model = model
        }, failure:  { errorMsg in
            print(errorMsg)
        })
        
        return false
    }
    
//    func fetchFirstData() {
//        apiController.getFirstData(success: { model in
//            self.model = model
//        }, failure:  { errorMsg in
//            print(errorMsg)
//        })
//    }
    
    
}
