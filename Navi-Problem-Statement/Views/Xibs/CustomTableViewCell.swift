//
//  CustomTableViewCell.swift
//  Navi-Problem-Statement
//
//  Created by Lakshay Saini on 11/05/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2.0
        }
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var closedAt: UILabel!
    
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            bottomView.isHidden = true
        }
    }
    
    static let identifier = "CustomTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CustomTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.layer.cornerRadius = 8
        self.containerView.layer.masksToBounds = true
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.frame = containerView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        contentView.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with data: Results, and isHidden: Bool) {
        title.text = data.title
        name.text = "Name: " + data.user.login
        createdAt.text = "Created At: " + data.created_at
        closedAt.text = "Closed At: " + (data.closed_at ?? "Not Closed")
        bottomView.isHidden = isHidden
        
        if isHidden {
            arrowImageView.image = UIImage(systemName: "chevron.down")
        } else {
            arrowImageView.image = UIImage(systemName: "chevron.up")
        }
        
        if data.user.avatar_url != nil {
            self.profileImageView.imageFromURL(urlString: data.user.avatar_url!,
                                            PlaceHolderImage: UIImage.init(named: "loader"))
        }
        else{
            self.profileImageView.image = UIImage.init(named: "inf")
        }
    }
    
}
