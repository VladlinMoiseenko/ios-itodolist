import Alamofire
import Foundation
import RxSwift
import RxAlamofire

class ApiController {
    
    let disposeBag = DisposeBag()
    let ENDPOINT_URL = "http://apitdlist.vladlin.ru/"
    
    func authorize(param:[String : Any], success: @escaping (Authorize) -> Void, failure: @escaping (String) -> Void) {
        RxAlamofire.requestData(.post,
                                ENDPOINT_URL+"v1/authorize",
                                parameters: param,
                                encoding: JSONEncoding.default,
                                headers: ["Content-Type": "application/json"])
            .observeOn(MainScheduler.instance)
//            .map { (r, json) -> [String: Any] in
//                guard let jsonDict = json as? [String: Any] else {
//                    return [:]
//                }
//
//                return jsonDict
//            }
//            .subscribe(onNext: { jsonDict in
//                print("j:", jsonDict)
//                let model = Authorize(jsonDict: jsonDict)
//                print("m:", model)
        
            .subscribe(onNext: { resp, data in
                //print(String(data: data, encoding: .utf8))
                print(try! JSONSerialization.jsonObject(with: data, options: .mutableLeaves))
                
                let parsedResult: Authorize = try! JSONDecoder().decode(Authorize.self, from: data)
                //let model = Authorize(jsonDict: jsonDict)
                print("r:", parsedResult)
                
                //let res = "success"

                //success(modfl)
                
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
