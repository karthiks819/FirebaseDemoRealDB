//
//  AddDataView.swift
//  FirebaseDBDemo
//
//  Created by Karthik on 11/02/21.
//

import UIKit
protocol CaptureDataProtocol {
    func enteredData(name:String, isActive: Bool, age: String)
}
class AddDataView: UIView {

    @IBOutlet weak var isActiveSwitch: UISwitch!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtName: UITextField!
    var delegate: CaptureDataProtocol?
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func isActiveAction(_ sender: UISwitch) {
        isActiveSwitch.isSelected = !isActiveSwitch.isSelected
    }
    @IBAction func addAction(_ sender: UIButton) {
        if (self.txtAge.text != "" && self.txtName.text != "") {
            delegate?.enteredData(name: self.txtName.text ?? "", isActive: isActiveSwitch.isSelected ? true : false, age: self.txtAge.text ?? "")
            self.removeFromSuperview()
        }
    }
    @IBAction func cancelAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    
}
