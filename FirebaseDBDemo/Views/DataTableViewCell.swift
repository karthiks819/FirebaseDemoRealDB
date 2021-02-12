//
//  DataTableViewCell.swift
//  FirebaseDBDemo
//
//  Created by Karthik on 11/02/21.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI(model: CustomerDataModel) {
        self.titleLabel.text = model.name
        self.statusView.backgroundColor = model.isActive ? .green:.red
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
