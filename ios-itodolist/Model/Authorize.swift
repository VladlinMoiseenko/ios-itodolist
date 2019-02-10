struct Authorize: Decodable {
    
    let status: Int
    //let data: Array<Any>
    
    enum CodingKeys: String, CodingKey {
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try! container.decode(Int.self, forKey: .status)
    }
    
    init() {
        self.status = 0
        //self.data = []
    }
    
    init(jsonDict: [String: Any]) {
        status = jsonDict["status"] as? Int ?? 0
        //data = jsonDict["data"] as? Array<Any> ?? []
    }
    
}
