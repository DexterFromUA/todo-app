//
//  ListView.swift
//  todo-app
//
//  Created by Dexter on 30.04.2021.
//

import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) private var colorScheme
    
    var changeModalState: () -> ()
    var items: FetchedResults<Item>
    @AppStorage("showOnlyComplited") var showCompleted: Bool = false
    
    var list: [Item] {
        var newList: [Item] = []
        
        if showCompleted {
            newList = items.filter { !$0.completed }
        } else {
            newList = items.map{ $0 }
        }
        
        return newList
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if list.count > 0 {
                    List {
                        ForEach(list) { (item) in
                            Button(action: {
                                onUpdate(item: item)
                            }, label: {
                                VStack {
                                    HStack {
                                        Image(systemName: item.completed ? "checkmark.square" : "square")
                                        
                                        Text(item.text!)
                                            .font(.headline)
                                        
                                        
                                        Spacer()
                                    }.foregroundColor(colorScheme == .dark ? .white : .black)
                                    
                                    HStack {
                                        Text("\(item.timestamp!, formatter: itemFormatter)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .padding(.top, 1)
                                        
                                        Spacer()
                                    }
                                }
                            })
                        }
                        .onDelete(perform: { indexSet in
                            onDelete(offsets: indexSet, items: items)
                        })
                    }
                    .listStyle(InsetGroupedListStyle())
                    .foregroundColor(.black)
                    .navigationBarTitle("ToDo's")
                    .navigationBarItems(trailing: Button {
                        changeModalState()
                    } label: {
                        Image(systemName: "plus")
                    }.frame(width: 30, height: 30, alignment: .center))
                } else {
                    Spacer()
                    
                    Text("All ToDos is done!")
                    
                    Spacer()
                }
                
                Toggle(isOn: $showCompleted) {
                    Text("Only not completed")
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
        }
    }
    
    private func onUpdate(item: Item) {
        item.completed.toggle()
        
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            
            let nsError = error as NSError
            fatalError("Error while changing status \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func onDelete(offsets: IndexSet, items: FetchedResults<Item>) {
        offsets.map{ items[$0] }.forEach(viewContext.delete)
        
//        for index in offsets {
//            let target = items[index]
//            viewContext.delete(target)
//        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Error while adding item \(nsError), \(nsError.userInfo)")
        }
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}
