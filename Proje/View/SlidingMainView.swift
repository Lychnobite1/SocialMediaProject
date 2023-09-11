//
//  SlidingMainView.swift
//  Proje
//
//  Created by MURAT BAŞER on 10.09.2023.
//

import SwiftUI
import SlidingTabView
struct SlidingMainView: View {
    @State private var currentIndex = 0
    @GestureState private var translation: CGFloat = 0
    var body: some View {
        VStack{
            SlidingTabView(selection: $currentIndex, tabs: ["Posts","Likes"])
                
            if currentIndex == 0 {
                SlidingPostView()
            }
            else if currentIndex == 1 {
                SlidingLikePostView()
            }
        }
    }
}

struct SlidingMainView_Previews: PreviewProvider {
    static var previews: some View {
        SlidingMainView()
    }
}
