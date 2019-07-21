//
//  ChatHomeView.swift
//  SwiftUI-WeChat
//
//  Created by Gesen on 2019/7/20.
//  Copyright © 2019 Gesen. All rights reserved.
//

import SwiftUI

struct ChatHomeView : View {
    var body: some View {
        List {
            ChatHomeSearchView()
                .listRowBackground(Color("background"))
                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        .background(Color(hex: 0xF1F1F1))
    }
}

#if DEBUG
struct ChatHomeView_Previews : PreviewProvider {
    static var previews: some View {
        ChatHomeView()
    }
}
#endif