//
//  UserTableViewCell.swift
//  MVVM Test
//
//  Created by me on 9/5/17.
//  Copyright © 2017 universe. All rights reserved.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    static var cellIdentifier: String {
        return "UserTableViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var item: UsersModel? {
        didSet {
            guard let item = item else {
                return
            }
            
            self.userImage.sd_setImage(with: URL(string: (item.picture?.medium)!))
            self.userName.text = item.name?.getFullName()
            self.userEmail.text = item.email
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
