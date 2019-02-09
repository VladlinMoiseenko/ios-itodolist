import Foundation
import RxSwift
import RxAlamofire

class ApiController {
    
    let disposeBag = DisposeBag()
    let ENDPOINT_URL = "http://apitdlist.dev.vladlin.ru/v1/task"
    
    func getFirstData(success: @escaping (TaskModel) -> Void, failure: @escaping (String) -> Void) {
        RxAlamofire.requestJSON(.get, ENDPOINT_URL)
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
