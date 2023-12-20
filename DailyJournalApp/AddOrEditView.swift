//
//  AddOrEditView.swift
//  DailyJournalApp
//
//  Created by Sofo Machurishvili on 20.12.23.
//

import SwiftUI

struct AddOrEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var newsViewModel: NewsViewModel
    
    @Binding var title: String
    @Binding var description: String
    @Binding var date: Date
    @Binding var category: Category
    @Binding var id: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Form {
                    TextField("News name", text: $title)
                    TextEditor(text: $description)
                        .frame(height: 100)
                    DatePicker("Choose date", selection: $date, displayedComponents: .date)
                    
                    Picker("Category", selection: $category) {
                        ForEach(Category.allCases) { option in
                            Text(String(describing: option))
                        }
                    }
                    .pickerStyle(.automatic)
                    
                    Button {
                        
                        if title != "" && description != "" {
                            
                            if id == nil {
                                newsViewModel.newsList.append(NewsModel(title: title, description: description, date: date, category: category))
                            } else {
                                if let index = newsViewModel.newsList.firstIndex (where: { news in news.id == id }) {
                                    newsViewModel.newsList[index] =
                                    NewsModel(title: title, description: description, date: date, id: id ?? "", category: category)
                                }
                            }
                            
                            id = nil
                            title = ""
                            description = ""
                            
                            dismiss()
                        }
                        
                    } label: {
                        Text("Save")
                            .frame(width: 300, height: 60)
                            .font(.title2)
                            .background(Color(red: 0.19, green: 0.11, blue: 0.68).opacity(0.1))
                            .cornerRadius(30)
                    }
                    
                    Button {
                        id = nil
                        title = ""
                        description = ""
                        
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .frame(width: 300, height: 60)
                            .font(.title2)
                            .background(Color(red: 0.19, green: 0.11, blue: 0.68).opacity(0.1))
                            .cornerRadius(30)
                        
                    }
                    
                    
                }
            }
            .navigationTitle(id == nil ? "Create a news" : "Edit the news")
        }
    }
}
