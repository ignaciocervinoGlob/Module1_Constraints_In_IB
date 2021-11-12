//
//  ChatViewController.swift
//  ConstraintsInIB
//
//  Created by Ignacio Cervino on 11/11/2021.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var  chatTableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var chatActivityIndicator: UIActivityIndicatorView!
    
    static let cellSpacingHeight: CGFloat = 5
    
    var messages: [Chat]? = [] {
        didSet {
            self.chatTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatActivityIndicator.startAnimating()
        MessageManager().retrieveFromJson() {
            [weak self] result in
            DispatchQueue.main.async {
                self?.chatActivityIndicator.stopAnimating()
                switch result {
                case .success(let messages):
                    self?.messages = messages
                    self?.errorLabel.isHidden = true
                    self?.chatActivityIndicator.isHidden = true
                case .failure(let error):
                    switch error {
                    case .fileNotFound:
                        self?.errorLabel.text = "File not found"
                    case .decodingProblem(let problem):
                        self?.errorLabel.text = "There was a problem decoding the data: \(problem)"
                    default:
                        self?.errorLabel.text = "There was a problem"
                    }
                    self?.errorLabel.isHidden = false
                    self?.messages = []
                }
            }
        }
        
        chatTableView.dataSource = self
        chatTableView.register(ChatSenderTableViewCell.getNib(), forCellReuseIdentifier: ChatSenderTableViewCell.getReuseIdentifier())
        chatTableView.register(ChatReceiverTableViewCell.getNib(), forCellReuseIdentifier: ChatReceiverTableViewCell.getReuseIdentifier())
        
        chatActivityIndicator.stopAnimating()
    }
}
    
extension ChatViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let message = self.messages?[indexPath.row] else { return UITableViewCell() }
        if message.username == "Me" {
            let cellReuseIdentifier = ChatSenderTableViewCell.getReuseIdentifier()
            var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ChatSenderTableViewCell
            if cell == nil {
                cell = ChatSenderTableViewCell()
            }
            cell?.configureCell(message)
            return cell ?? UITableViewCell()
        } else {
            let cellReuseIdentifier = ChatReceiverTableViewCell.getReuseIdentifier()
            var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ChatReceiverTableViewCell
            if cell == nil {
                cell = ChatReceiverTableViewCell()
            }
            cell?.configureCell(message)
            return cell ?? UITableViewCell()
        }
    }
}
