//
//  ModalView.swift
//  todo-app
//
//  Created by Dexter on 30.04.2021.
//

import SwiftUI

struct ModalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var str = ""
    @State private var emptyStr = false
    
    var changeModalState: () -> ()
    
    var body: some View {
        VStack {
            Text("Type new ToDo")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 70)
            
            TextField("Type here ...", text: $str)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Spacer()
            
            Button(action: onAdd, label: {
                Text("Add ToDo")
                    .foregroundColor(.green)
                    .frame(width: 200, height: 50, alignment: .center)
                    .border(Color.green, width: 2)
                    .cornerRadius(5)
            })
            .padding(.bottom)
        }
        .alert(isPresented: $emptyStr) { () -> Alert in
            Alert(title: Text("Error"), message: Text("String can't be empty"), dismissButton: .default(Text("OK")))
        }
    }
    
    func onAdd() {
        if str.isEmpty {
            emptyStr.toggle()
        } else {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.completed = false
            newItem.timestamp = Date()
            newItem.text = str
            
            do {
                try viewContext.save()
                changeModalState()
            } catch {
                let nsError = error as NSError
                fatalError("Error while adding item \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
