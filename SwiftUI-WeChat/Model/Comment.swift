//
//  Comment.swift
//  SwiftUI-WeChat
//
//  Created by Gesen on 2020/1/4.
//  Copyright © 2020 Gesen. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let name: String
    let content: String
}

extension Comment: Identifiable {
    var id: UUID { UUID() }
}
