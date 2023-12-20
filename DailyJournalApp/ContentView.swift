//
//  ContentView.swift
//  DailyJournalApp
//
//  Created by Sofo Machurishvili on 20.12.23.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddOrEditView = false
    
    @StateObject var newsViewModel = NewsViewModel()
    
    @State var title: String = ""
    @State var description: String = ""
    @State var date: Date = Date()
    @State var category: Category = .politics
    @State var id: String? = nil
    @State var filterByDate: Date = Date()
    @State var filteredByDate: Date? = nil
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading) {
                
                VStack {
                    DatePicker("Date", selection: $filterByDate, displayedComponents: .date)
                    
                    HStack {
                        HStack {
                            Button {
                                filteredByDate = nil
                            } label: {
                                Text("Clear")
                            }
                        }
                        .padding()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .background(Color(red: 0.19, green: 0.11, blue: 0.68).opacity(0.1))
                        .cornerRadius(20)
                        
                        Spacer()
                        
                        Button {
                            filteredByDate = filterByDate
                        } label: {
                            Text("Filter")
                        }
                        .padding()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .background(Color(red: 0.19, green: 0.11, blue: 0.68).opacity(0.1))
                        .cornerRadius(20)
                    }
                }
            }
            
            .padding(.horizontal)
            
            VStack(alignment: .center) {
                Button("Add news") {
                    showAddOrEditView.toggle()
                }
                .sheet(isPresented: $showAddOrEditView) {
                    AddOrEditView(
                        newsViewModel: newsViewModel,
                        title: $title,
                        description: $description,
                        date: $date,
                        category: $category,
                        id: $id
                    )
                }
            }
            .padding()
            .frame(width: 300)
            .background(Color(red: 0.19, green: 0.11, blue: 0.68).opacity(0.1))
            .cornerRadius(20)
            
            VStack {
                if newsViewModel.newsList.count == 0 {
                    ZStack {
                        Image("news2")
                            .resizable()
                        
                        
                        VStack {
                            Text("News list is empty")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray)
                                .padding()
                                .border(Color.white, width: 6)
                                .cornerRadius(6)
                        }
                        .offset(x: 0, y: -160)
                    }
                } else {
                    EditButton()
                    
                    List {
                        ForEach(Category.allCases, id: \.id) { category in
                            
                            if newsViewModel.filteredData(category: category, date: filteredByDate).count > 0 {
                                Section(header: Text(String(describing: category))) {
                                    
                                    ForEach(newsViewModel.filteredData(category: category, date: filteredByDate), id: \.id) { news in
                                        
                                        NewsView(news: news, edit: {
                                            id = news.id
                                            title = news.title
                                            description = news.description
                                            date = news.date
                                            
                                            showAddOrEditView.toggle()
                                        })
                                    }
                                    .onDelete(perform: { indexSet in
                                        newsViewModel.newsList.remove(atOffsets: indexSet)
                                    })
                                    .onMove(perform: { indices, newOffset in
                                        newsViewModel.newsList.move(fromOffsets: indices, toOffset: newOffset)
                                    })
                                }
                                .headerProminence(.increased)
                                .listRowBackground(Color.mint)
                            }
                        }
                    }
                }
            }
            Spacer()
        }        
    }
}

#Preview {
    ContentView()
}
