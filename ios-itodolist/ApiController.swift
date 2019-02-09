import Foundation
import RxSwift
import RxAlamofire

class ApiController {
    
    let disposeBag = DisposeBag()
    let ENDPOINT_URL = "http://apitdlist.vladlin.ru/"
    
    func authorize(success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        
        let productObject = Credentials(username: "demo11", password: "demo11")
        let params = try? JSONEncoder().encode(productObject)
        
        //RxAlamofire.requestJSON(.post, ENDPOINT_URL+"v1/authorize", parameters: params as? [String: Any], encoding: JSONEncoder.default, headers: [ "Content-Type": "application/json"])
        RxAlamofire.requestJSON(.post, ENDPOINT_URL+"v1/authorize", parameters: params)
        //RxAlamofire.requestJSON(.post, ENDPOINT_URL+"v1/authorize")
            .observeOn(MainScheduler.instance)
            .map { (r, json) -> [String: Any] in
                guard let jsonDict = json as? [String: Any] else {
                    return [:]
                }
                return jsonDict
            }
            .subscribe(onNext: { jsonDict in
                print("j:", jsonDict)
                
                let res = "success"

                success(res)
                
            }, onError: { error in
                failure("Error")
            })
            .disposed(by: disposeBag)
    }
    
    func getFirstData(success: @escaping (TaskModel) -> Void, failure: @escaping (String) -> Void) {
        RxAlamofire.requestJSON(.get, "http://apitdlist.dev.vladlin.ru/v1/task")
            .observeOn(MainScheduler.instance)
            .map { (r, json) -> [String: Any] in
                guard let jsonDict = json as? [String: Any] else {
                    return [:]
                }
                return jsonDict
            }
            .subscribe(onNext: { jsonDict in
                let model = TaskModel(jsonDict: jsonDict)
                //print("m:", model)
                
                if let array = jsonDict["data"] as? [Any] {
                    for object in array {
                        if let ob = object as? [String: Any] {
                            let dmodel = TaskDataModel(json: ob)
                            //print("dm:", dmodel)
                        }
                    }
                }
                success(model)
                
            }, onError: { error in
                failure("Error")
            })
            .disposed(by: disposeBag)
    }
    
}
