//
//  ViewController.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/25/22.
//

import UIKit

class ViewController: UIViewController {
    let serviceManager = ServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let params = Cred(email: "test01@example.com", password: "123456")
        
        serviceManager.post(url: Constants.URLs.Users.login, parameters: params.asDictionary(), headers: nil, success: nil, failure: nil)
    }
    
}

extension Encodable {
    func asDictionary() -> [String: Any] {
        let data = try! JSONEncoder().encode(self)
        guard let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            fatalError()
        }
        return dictionary
    }
}

struct Cred: Encodable {
    var email: String?
    var password: String?
}
