//
//  ViewControllerTableViewCell.swift
//  CustomTableView
//
//  Created by 2B on 11/14/17.
//  Copyright © 2017 Automata. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewControllerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTeam: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static var identifer: String {
        return "Cell"
    }
    
    var item: Hero? {
        didSet {
            guard let item = item else { return }
            
            self.labelName.text = item.name
            self.labelTeam.text = item.team
            if let imageUrl = item.imageUrl {
                self.heroImage.af_setImage(
                    withURL: URL(string: imageUrl)!,
                    placeholderImage: nil,
                    filter: nil,
                    imageTransition: .crossDissolve(0.2)
                )
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.labelName.text = ""
        self.labelTeam.text = ""
        self.heroImage.af_cancelImageRequest()
    }
    
}
