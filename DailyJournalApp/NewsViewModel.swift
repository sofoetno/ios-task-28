//
//  NewsViewModel.swift
//  DailyJournalApp
//
//  Created by Sofo Machurishvili on 20.12.23.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var newsList: [NewsModel] = []
    
    func filteredData(category: Category, date: Date? = nil) -> [NewsModel] {

        return newsList.filter { news in
            news.category == category && (date == nil || (news.date.formatted(date: .abbreviated, time: .omitted) == date!.formatted(date: .abbreviated, time: .omitted)))
        }
        
    }

    
}
