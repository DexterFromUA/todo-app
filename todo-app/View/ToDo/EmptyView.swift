//
//  EmptyView.swift
//  todo-app
//
//  Created by Dexter on 30.04.2021.
//

import SwiftUI

struct EmptyView: View {
    var changeModalState: () -> ()
    
    var body: some View {
        VStack {
            Text("Have no items")
            HStack {
                Button("Add") {
                    changeModalState()
                }
                Text("your first one")
            }
        }
    }
}
