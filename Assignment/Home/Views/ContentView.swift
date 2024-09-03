//
//  ContentView.swift
//  Assignment
//
//  Created by Urmila on 03/09/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var isStatsSheetPresented = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 16) {
                    CarouselView(items: viewModel.carouselItems)
                        .frame(height: 250)
                    
                    SearchBar(text: $viewModel.searchText)
                        .padding(.horizontal)
                    
                    ListView(items: viewModel.filteredListItems)
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .scrollBounceBehavior(.automatic)
            .safeAreaInset(edge: .top) { Color.clear.frame(height: 0) }
            .safeAreaInset(edge: .bottom) { Color.clear.frame(height: 0) }
            
            FloatingActionButton(isPresented: $isStatsSheetPresented)
        }
        .sheet(isPresented: $isStatsSheetPresented) {
            ListBottomSheetView(viewModel: viewModel)
                .presentationDetents([.medium])
        }
    }
}
