//
//  CustomCell.swift
//  movieApp
//
//  Created by Mustafa on 22.02.2022.
//

import UIKit

protocol CustomTableCellDelegate: AnyObject {
    func btnClicked(tag: Int)
}

class CustomCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var showInformation: UIButton!
    
    weak var customTableCellDelegate: CustomTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //MARK: - Buttons
    @IBAction func showInformation(_ sender: UIButton) {
        self.customTableCellDelegate?.btnClicked(tag: sender.tag)
    }
}
