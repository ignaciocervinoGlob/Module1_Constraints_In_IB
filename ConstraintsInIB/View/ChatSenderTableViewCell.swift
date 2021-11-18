//
//  ChatSenderTableViewCell.swift
//  ConstraintsInIB
//
//  Created by Ignacio Cervino on 11/11/2021.
//

import UIKit

class ChatSenderTableViewCell: UITableViewCell {

    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var messageUILabel: UILabel!
    @IBOutlet weak var timeUILabel: UILabel!
    
    static let cellIdentifier = "ChatSenderTableViewCell"
    
    static func getReuseIdentifier() -> String {
        return cellIdentifier
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: "ChatSenderTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ message: Chat) {
        chatView.layer.cornerRadius = 8
        chatView.clipsToBounds = true
        messageUILabel.text = message.message
        timeUILabel.text = message.time
    }
    
}
