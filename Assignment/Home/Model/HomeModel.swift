//
//  HomeModel.swift
//  Assignment
//
//  Created by Urmila on 03/09/24.
//

import SwiftUI

struct CarouselItem: Identifiable {
    let id = UUID()
    let imageName: String
}

struct ListItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

struct CharacterCount: Hashable {
    let character: Character
    let count: Int
}
