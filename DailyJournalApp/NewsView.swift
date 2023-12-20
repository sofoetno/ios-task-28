//
//  NewsView.swift
//  DailyJournalApp
//
//  Created by Sofo Machurishvili on 20.12.23.
//

import SwiftUI

struct NewsView: View {
    var news: NewsModel
    var edit: () -> Void
    
    var body: some View {
        
        HStack {
            Image("news")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            Text(news.title)
            Spacer()
            Text(news.date.formatted(date: .abbreviated, time: .omitted) )
            
            Button {
                edit()
            } label: {
                Image(systemName: "pencil")
            }
        }
        
    }
}

#Preview {
    NewsView(news: NewsModel(title: "Some title", description: "Some description", date: Date(), category: .politics)) {
    }
}
