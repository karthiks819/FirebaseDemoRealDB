//
//  ViewController.swift
//  FirebaseDBDemo
//
//  Created by Karthik on 10/02/21.
//

import UIKit
import Firebase
import FirebaseDatabase


class ViewController: UIViewController, CaptureDataProtocol {
    
    
    @IBOutlet weak var dataTableView: UITableView!
    var addDataView:AddDataView?
    let cellId = "DataTableViewCell"
    var ref: DatabaseReference!
    var savedData = [Any]()
    
    var modelArray = [CustomerDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        let mainArr = ref.child("Us")
        
        mainArr.getData { (err, da) in
            if let daa = da.value as? NSArray {
                self.savedData = daa as! [Any]
                self.modelArray = self.getModelFromAnyData(data: self.savedData)
                DispatchQueue.main.async {
                    
                    self.dataTableView.reloadData()
                }
            }
        }
        
        
        
        mainArr.observeSingleEvent(of: .childAdded, with: { (snapshot) in
            if let daa = snapshot.value as? NSArray {
                self.savedData = daa as! [Any]
                self.modelArray.removeAll()
                self.modelArray = self.getModelFromAnyData(data: self.savedData)
                DispatchQueue.main.async {
                    
                    self.dataTableView.reloadData()
                }}
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    func getFinalDataAsDic(model: CustomerDataModel) -> NSDictionary {
        let userInfoDictionary = ["index" : NSNumber(value: model.index),
                                  "uid" : model.uid,
                                  "isActive" : model.isActive,
                                  "balance" : model.balance,
                                  "age" : NSNumber(value: model.age),
                                  "eyeColor" : model.eyeColor,
                                  "name" : model.name,
                                  "gender" : model.gender,
                                  "company" : model.company,
                                  "email" : model.email,
                                  "phone" : model.phone,
                                  "address" : model.address,
                                  "about" : model.about,
                                  "friends" : self.getArrayFrom(model: model.friends)
        ] as [String : Any]
        
        return userInfoDictionary as NSDictionary
    }
    
    func getArrayFrom(model: [Friend]) -> NSArray {
        let arr = NSArray()
        for i in model {
            let data = ["id":NSNumber(integerLiteral: i.id), "name":i.name] as [String : Any]
            arr.adding(data as NSDictionary)
        }
        return arr
    }
    
    func updateData() {
        let mainArr = ref.child("Us")
        mainArr.getData { (err, da) in
            if let daa = da.value as? NSArray {
                self.savedData = daa as! [Any]
                
                DispatchQueue.main.async {
                    self.modelArray.removeAll()
                    self.modelArray = self.getModelFromAnyData(data: self.savedData)
                    self.dataTableView.reloadData()
                }
                
            }
        }
    }
    
    func setData() {
        let mainArr = ref.child("Us")
        let realData = CustomerDataModel(index: 0, uid: "random", isActive: true, balance: "@2343", age: 25, eyeColor: "red", name: "cnu", gender: "male", company: "abc", email: "asdfdsd", phone: "32423423423424`", address: "sdfsfsfdsfd", about: "sdfsfsdfdsf", friends: [Friend(id: 0, name: "first")])
        
        self.savedData.append(self.getFinalDataAsDic(model: realData))
        mainArr.setValue(self.savedData) { (err, ref) in
            if let error = err {
                print("userInfoDictionary was not saved: \(error.localizedDescription)")
            } else {
                print("userInfoDictionary saved successfully!")
                
            }
        }
    }
    func setData(name: String, age: String, isActive: Bool) {
        let mainArr = ref.child("Us")
        let realData = CustomerDataModel(index: 0, uid: "random", isActive: isActive, balance: "@2343", age: Int(age) ?? 0, eyeColor: "red", name: name, gender: "male", company: "abc", email: "asdfdsd", phone: "32423423423424`", address: "sdfsfsfdsfd", about: "sdfsfsdfdsf", friends: [Friend(id: 0, name: "first")])
        
        self.savedData.append(self.getFinalDataAsDic(model: realData))
        mainArr.setValue(self.savedData) { (err, ref) in
            if let error = err {
                print("userInfoDictionary was not saved: \(error.localizedDescription)")
                
            } else {
                print("userInfoDictionary saved successfully!")
                self.updateData()
            }
        }
    }
    func getModelFromAnyData(data: [Any]) -> [CustomerDataModel] {
        var modelArr = [CustomerDataModel]()
        guard  let data1:[[String:Any]] = data as? [[String:Any]] else {
            return modelArray
        }
        for case let i: [String:Any] in data1 {
            modelArr.append(CustomerDataModel(index: i["index"] as? Int ?? 0, uid: "", isActive: i["isActive"] as? Bool ?? true, balance: "", age:i["age"] as? Int ?? 0, eyeColor: "", name: i["name"] as? String ?? "", gender: "", company: "", email: "", phone: "", address: "", about: "", friends: [Friend(id: 0, name: "")]))
            
        }
        return modelArr
    }
    
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        if !self.view.subviews.contains(addDataView ?? UIView()) {
            addDataView = AddDataView.fromNib()
            addDataView?.frame = self.view.frame
            addDataView?.delegate = self
            self.view.addSubview(addDataView!)
        }
        
    }
    
    func enteredData(name: String, isActive: Bool, age: String) {
        print(name, isActive, age)
        self.setData(name: name, age: age, isActive: isActive)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? DataTableViewCell else {
            return UITableViewCell()
        }
        let model = self.modelArray[indexPath.row]
        cell.updateUI(model: model)
        return cell
    }
}
extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
