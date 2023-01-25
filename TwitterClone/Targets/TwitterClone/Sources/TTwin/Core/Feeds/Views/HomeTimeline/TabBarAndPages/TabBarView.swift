//
//  TabBarView.swift
//  TTwin
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedFeeds = 0
    @State private var isSearchShowing = false
    
    var body: some View {
        TabView {
            ZStack {
                Rectangle()
                    .foregroundStyle(.streamBlue) // From the color extension
                    .opacity(0.1)
                    .ignoresSafeArea()
               Text("Home view")
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            Text("")
                .tabItem {
                    Button {
                        self.isSearchShowing.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
                .sheet(isPresented: $isSearchShowing, content: SearchView.init)
            
            Text("")
                .tabItem {
                    Image(systemName: "waveform.and.mic")
                    Text("Spaces")
                }
            
            Text("")
                .tabItem {
                    Image(systemName: "bell")
                    Text("Notifications")
                }
                .badge(10)
            
            Text("")
                .tabItem {
                    Image(systemName: "text.bubble")
                    Text("Chats")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .preferredColorScheme(.dark)
    }
}
