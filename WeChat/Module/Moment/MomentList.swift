//
//  MomentList.swift
//  WeChat
//
//  Created by Gesen on 2020/10/16.
//  Copyright © 2020 Gesen. All rights reserved.
//

import SwiftUI
import Refresh

struct MomentList: View {
    @State private var moments: [Moment] = []
    @State private var footerRefreshing = false
    @State private var noMore = false
    
    var body: some View {
        ScrollView {
            /// 跟 VStack 功能类似，不过不会一次性全部把 view 加载出来，会随着滚动陆续加载出来
            /// https://juejin.cn/post/6891936267248877581
            LazyVStack(spacing: 0) {
                Header()
                    // 将 Header 的底部坐标变化传递给上层，用于导航栏变化
                    // TODO: anchorPreference??
                    .anchorPreference(key: MomentHome.NavigationKey.self, value: .bottom) { [$0] }
                
                ForEach(self.moments) { moment in
                    VStack(spacing: 0) {
                        MomentRow(moment: moment)
                        Separator()
                    }
                }
            }
            .background(Color("cell"))
            // 底部刷新控件
            RefreshFooter(refreshing: $footerRefreshing, action: loadMore) {
                Text(noMore ? "没有更多了" : "加载中...")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
                    .padding(.top, 6)
                    .padding(.bottom, 20)
            }
            .preload(offset: 200)
            .noMore(noMore) // 也可以在 Footer 外部判断 noMore，直接不显示 Footer
        }
        .enableRefresh()
        .onAppear(perform: load)
    }
    
    func load() {
        guard moments.isEmpty else { return }
        moments = Moment.page1
    }
    
    func loadMore() {
        // TODO: 这里的作用？？？？
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.moments.append(contentsOf: Moment.page2)
            self.footerRefreshing = false
            self.noMore = true
        }
    }
    
    struct Header: View {
        let member: Member = .me
        
        var body: some View {
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 0) {
                    Image(member.background ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .clipped()
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 20)
                }
                
                HStack(spacing: 20) {
                    Text(member.name)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .shadow(radius: 2)
                        // 对齐方式，再细化
                        .alignmentGuide(VerticalAlignment.center) { d in 20 }
//                        .alignmentGuide(HorizontalAlignment.center, computeValue: { d in -100 })
                    
                    Image(member.icon)
                        .resizable()
                        .cornerRadius(6)
                        .frame(width: 70, height: 70)
                        .padding(.trailing, 12)
                    // .frame(width: 70, height: 70) 放前面和放后面效果还不一样。。。
//                        .frame(width: 70, height: 70)
                }
            }
        }
    }
}

struct MomentList_Previews: PreviewProvider {
    static var previews: some View {
        MomentList()
    }
}
