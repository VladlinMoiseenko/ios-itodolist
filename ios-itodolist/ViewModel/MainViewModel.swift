import RxSwift
import RxCocoa

class MainViewModel {
    
    let apiController: ApiController
    
    private var model: TaskData
    
    init(apiController: ApiController) {
        self.apiController = apiController
        self.model = TaskData()
    }
    
    func fetchTasksData() {
        apiController.fetchTasksData(success: { model in
            self.model = model
            print("model:", model)
            
        }, failure: { errorMsg in
            print(errorMsg)
        })
    }
}
