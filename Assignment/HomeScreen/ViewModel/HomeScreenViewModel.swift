//
//  HomeScreenViewModel.swift
//  Assignment
//
//  Created by Urmila on 04/09/24.
//

import Foundation
import Combine

class HomeScreenViewModel {
    @Published var carouselItems: [HomeCarouselItem] = []
    @Published var listItems: [HomeListItem] = []
    @Published var filteredListItems: [HomeListItem] = []
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadSampleData()
        setupSearchPublisher()
    }
    
    private func loadSampleData() {
        carouselItems = [
            HomeCarouselItem(imageName: "cutie"),
            HomeCarouselItem(imageName: "bluePic"),
            HomeCarouselItem(imageName: "images"),
            HomeCarouselItem(imageName: "rose"),
            HomeCarouselItem(imageName: "green"),
            HomeCarouselItem(imageName: "cutie"),
            HomeCarouselItem(imageName: "bluePic"),
            HomeCarouselItem(imageName: "images"),
            HomeCarouselItem(imageName: "rose")
        ]
        
        listItems = [
            HomeListItem(title: "Morning Yoga", subtitle: "Start the day with a stretch"),
            HomeListItem(title: "Email Check", subtitle: "Catch up on messages"),
            HomeListItem(title: "Commute Playlist", subtitle: "Music for the road"),
            HomeListItem(title: "Lunch Break", subtitle: "Recharge for the afternoon"),
            HomeListItem(title: "Afternoon Walk", subtitle: "A quick break outside"),
            HomeListItem(title: "Coffee Chat", subtitle: "Catch up with a colleague"),
            HomeListItem(title: "Project Deadline", subtitle: "Final touches"),
            HomeListItem(title: "Dinner Reservation", subtitle: "Evening plans"),
            HomeListItem(title: "Evening News", subtitle: "Stay informed"),
            HomeListItem(title: "Family Time", subtitle: "Unwind with loved ones"),
            HomeListItem(title: "Night Reading", subtitle: "A chapter before bed"),
            HomeListItem(title: "Sleep Tracker", subtitle: "Monitor your rest")
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
    
    var topCharacterCounts: [HomeCharacterCount] {
        let characterOccurrences = filteredListItems
            .flatMap { $0.title }
            .filter { !$0.isWhitespace && $0.isLetter }
            .reduce(into: [:]) { counts, char in
                counts[char, default: 0] += 1
            }
        let sortedOccurrences = characterOccurrences.sorted { $0.value > $1.value }
        return Array(sortedOccurrences.prefix(3)).map { HomeCharacterCount(character: $0.key, count: $0.value) }
    }
    
    var filteredItemsCount: Int {
        filteredListItems.count
    }
}
