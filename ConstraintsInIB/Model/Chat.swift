//
//  Chat.swift
//  ConstraintsInIB
//
//  Created by Ignacio Cervino on 12/11/2021.
//

import Foundation

enum UsernameType: String {
    case Me = "Me", Support = "Support"
}

struct Chat: Decodable {
    var username: String
    var message: String
    var time: String
    
    enum CodingKeys: String, CodingKey {
        case username,message
        case time = "timeMessage"
    }
}
