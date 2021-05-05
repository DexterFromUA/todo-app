//
//  ToDoView.swift
//  todo-app
//
//  Created by Dexter on 30.04.2021.
//

import SwiftUI

struct ToDoView: View {
    @State private var modalShow = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)], animation: .default) var items: FetchedResults<Item>
    
    var body: some View {
        Group {
            if items.count > 0 {
                ListView(changeModalState: changeModalState, items: items)
            } else {
                EmptyView(changeModalState: changeModalState)
            }
        }.sheet(isPresented: $modalShow, content: {
            ModalView(changeModalState: changeModalState)
        })
    }
    
    func changeModalState() {
        modalShow.toggle()
    }
}
