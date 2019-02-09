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
//
//    private var model: TaskModel {
//        willSet {
//            title.value = "[TITLE FO:]\(newValue.title)"
//        }
//    }

    init(apiController: ApiController) {
        self.apiController = apiController
        //self.model = TaskModel()
    }

    func apiAuthorize(_ username:String, _ password:String) -> Bool {
        
        // demo11 demo11
        

        
        
        //Credentials
//        let productObject = Credentials(username: "demo11", password: "demo11")
//        let encodedData = try? JSONEncoder().encode(productObject)
//        
//        print("j:", encodedData)
        
//        let array = [ "one", "two" ]
//
//        let r = json(from:array as Any)
//
//
//        print(username)
//        print(password)
        
        
        apiController.authorize(success: {_ in
           return true
        }, failure:  { errorMsg in
            print(errorMsg)
        })
        
        return false
    }
    
//    func json(from object:Any) -> String? {
//        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
//            return nil
//        }
//        return String(data: data, encoding: String.Encoding.utf8)
//    }
    
    
//    func fetchFirstData() {
//        apiController.getFirstData(success: { model in
//            self.model = model
//        }, failure:  { errorMsg in
//            print(errorMsg)
//        })
//    }
}
