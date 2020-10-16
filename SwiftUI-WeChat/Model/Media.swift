//
//  Media.swift
//  SwiftUI-WeChat
//
//  Created by Gesen on 2020/1/4.
//  Copyright © 2020 Gesen. All rights reserved.
//

import Foundation

struct Media: Codable {
    let cover: String?
    let width: Double?
    let height: Double?
    let url: String
}

extension Media: Identifiable {
    var id: UUID { UUID() }
}
