//
//  HomeViewModel.swift
//  Assignment
//
//  Created by Urmila on 03/09/24.
//

import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var carouselItems: [CarouselItem] = []
    @Published var listItems: [ListItem] = []
    @Published var filteredListItems: [ListItem] = []
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadSampleData()
        setupSearchPublisher()
    }
    
    private func loadSampleData() {
        carouselItems = [
            // Sample data
            CarouselItem(imageName: "cutie"),
            CarouselItem(imageName: "cutie"),
            CarouselItem(imageName: "bluePic"),
            CarouselItem(imageName: "images"),
            CarouselItem(imageName: "rose"),
            CarouselItem(imageName: "green"),
            CarouselItem(imageName: "cutie"),
            CarouselItem(imageName: "bluePic"),
            CarouselItem(imageName: "images"),
            CarouselItem(imageName: "rose")
        ]
        
        listItems = [
            ListItem(title: "Morning Yoga", subtitle: "Start the day with a stretch"),
            ListItem(title: "Email Check", subtitle: "Catch up on messages"),
            ListItem(title: "Commute Playlist", subtitle: "Music for the road"),
            ListItem(title: "Lunch Break", subtitle: "Recharge for the afternoon"),
            ListItem(title: "Afternoon Walk", subtitle: "A quick break outside"),
            ListItem(title: "Coffee Chat", subtitle: "Catch up with a colleague"),
            ListItem(title: "Project Deadline", subtitle: "Final touches"),
            ListItem(title: "Dinner Reservation", subtitle: "Evening plans"),
            ListItem(title: "Evening News", subtitle: "Stay informed"),
            ListItem(title: "Family Time", subtitle: "Unwind with loved ones"),
            ListItem(title: "Night Reading", subtitle: "A chapter before bed"),
            ListItem(title: "Sleep Tracker", subtitle: "Monitor your rest")
        ]
        
        filteredListItems = listItems
    }
    
    private func setupSearchPublisher() {
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { [unowned self] query in
                self.listItems.filter { $0.title.localizedCaseInsensitiveContains(query) || query.isEmpty }
            }
            .assign(to: &$filteredListItems)
    }
    
    var topCharacterCounts: [CharacterCount] {
        let characterOccurrences = filteredListItems
            .flatMap { $0.title }
            .filter { !$0.isWhitespace && $0.isLetter }
            .reduce(into: [:]) { counts, char in
                counts[char, default: 0] += 1
            }
        let sortedOccurrences = characterOccurrences.sorted { $0.value > $1.value }
        return Array(sortedOccurrences.prefix(3)).map { CharacterCount(character: $0.key, count: $0.value) }
    }
    
    var filteredItemsCount: Int {
        filteredListItems.count
    }
}
