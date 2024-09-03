//
//  ListView.swift
//  Assignment
//
//  Created by Urmila on 03/09/24.
//

import SwiftUI

struct ListView: View {
    let items: [ListItem]
    
    var body: some View {
        LazyVStack {
            ForEach(items) { item in
                ListItemView(item: item)
            }
        }
    }
}
