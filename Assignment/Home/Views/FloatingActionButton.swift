//
//  FloatingActionButton.swift
//  Assignment
//
//  Created by Urmila on 03/09/24.
//

import SwiftUI

struct FloatingActionButton: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: { isPresented.toggle() }) {
                    Image("dots")
                        .frame(width: 60, height: 60)
                        .background(Circle().fill(Color.blue))
                        .clipShape(Circle())
                        .padding()
                }
                .shadow(
                    color: Color.black.opacity(0.2), 
                    radius: 10, x: 0, y: 5
                )
                .padding(.bottom, 16)
            }
        }
    }
}
