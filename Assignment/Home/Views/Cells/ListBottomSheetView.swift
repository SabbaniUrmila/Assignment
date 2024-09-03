//
//  ListBottomSheetView.swift
//  Assignment
//
//  Created by Urmila on 03/09/24.
//

import SwiftUI

struct ListBottomSheetView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("List Statistics")
                .font(.headline)
            Text("Total Items: \(viewModel.filteredItemsCount)")
            Text("Top 3 Characters from the list:")
            ForEach(
                viewModel.topCharacterCounts,
                id: \.self
            ) { characterCount in
                Text("\(characterCount.character): \(characterCount.count)")
            }
            
            Spacer()
        }
        .padding()
    }
}
