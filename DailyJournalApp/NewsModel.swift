//
//  NewsModel.swift
//  DailyJournalApp
//
//  Created by Sofo Machurishvili on 20.12.23.
//

import Foundation

enum Category: CaseIterable, Identifiable {
    case sport
    case enetrtainment
    case politics

    var id: Self { self }
}

struct NewsModel: Identifiable {
    var title: String
    var description: String
    var date: Date
    var id: String = UUID().uuidString
    var category: Category
}
