//
//  ListItemView.swift
//  Assignment
//
//  Created by Urmila on 03/09/24.
//

import SwiftUI

struct ListItemView: View {
    let item: ListItem
    
    var body: some View {
        VStack {
            HStack {
                Image("bluePic")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(5)
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                Spacer()
            }
        }
        .padding()
        .background(Color(red: 209/255, green: 230/255, blue: 224/255))
        .cornerRadius(15)
        .padding(.bottom, 5)
    }
}
