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
    
    init(apiController: ApiController) {
        self.apiController = apiController
    }

     func apiAuthorize(_ username:String, _ password:String) {
        
        let jsonParam = try? JSONEncoder().encode(Credentials(username: username, password: password))
        let param = try? JSONSerialization.jsonObject(with: jsonParam!, options: []) as? [String : Any]

        apiController.authorize(param: param as! [String : Any], success: {modelAuthorize in

            if modelAuthorize.status == 1 {
                let param = ["authorization_code" : modelAuthorize.authorizationCode]
                self.apiController.accesstoken(param: param as! [String : Any], success: {modelAccesstoken in
                    
                    if modelAccesstoken.status == 1 {
                        UserDefaults.standard.set(modelAccesstoken.accessToken, forKey: "accessToken")
                    } else {
                        UserDefaults.standard.set("empty", forKey: "accessToken")
                    }
                    
                }, failure: { errorMsg in
                    print(errorMsg)
                })
                
            } else {
                UserDefaults.standard.set("empty", forKey: "accessToken")
            }
            
        }, failure: { errorMsg in
            print(errorMsg)
        })
        
    }

}
