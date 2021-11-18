//
//  ChatReceiverTableViewCell.swift
//  ConstraintsInIB
//
//  Created by Ignacio Cervino on 11/11/2021.
//

import UIKit

class ChatReceiverTableViewCell: UITableViewCell {

    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var usernameUILabel: UILabel!
    @IBOutlet weak var messageUILabel: UILabel!
    @IBOutlet weak var timeUILabel: UILabel!
    
    static let cellIdentifier = "ChatRecieverTableViewCell"
    
    static func getReuseIdentifier() -> String {
        return cellIdentifier
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: "ChatReceiverTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ message: Chat) {
        chatView.layer.cornerRadius = 2
        chatView.clipsToBounds = true
        usernameUILabel.text = message.username
        messageUILabel.text = message.message
        timeUILabel.text = message.time
    }
    
}
