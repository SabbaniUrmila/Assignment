//
//  CarouselView.swift
//  Assignment
//
//  Created by Urmila on 03/09/24.
//

import SwiftUI

struct CarouselView: View {
    let items: [CarouselItem]
    @State private var currentIndex: Int = 0
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(items.indices, id: \.self) { index in
                    Image(items[index].imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .cornerRadius(8)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 250)
            .cornerRadius(8)
            .onAppear(perform: startTimer)
            .onDisappear(perform: stopTimer)
            
            pageIndicators
        }
    }
    
    private var pageIndicators: some View {
        HStack(spacing: 7) {
            ForEach(items.indices, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color.blue : Color.gray)
                    .frame(width: 7, height: 7)
            }
        }
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(
            withTimeInterval: 3.0,
            repeats: true
        ) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % items.count
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search", text: $text)
                .padding(.vertical, 7)
        }
        .padding(.horizontal, 10)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
