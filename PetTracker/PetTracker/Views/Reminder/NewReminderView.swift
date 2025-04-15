//
//  NewPetView 2.swift
//  PetTracker
//
//  Created by Nyomi Bell on 4/4/25.
//


//
//  Home.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/14/25.
//

import SwiftUI

struct NewReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var authViewModel = AuthViewModel()
    //    @State private var newPet = ""
    @State var name = ""
    @State var notes = ""
    @State var date = ""
    @State var chosenDate = Date()
    let dateFormatter = DateFormatter()

                          init(){
        authViewModel.getData()
    }
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("New Reminder")){
                    TextField("Reminder", text: $name)
                    TextField("Notes", text: $notes)
                     DatePicker(
                        "Date",
                        selection: $chosenDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.graphical)

                }
                
            }
 
            .navigationBarItems(trailing: Button(action: {
                dateFormatter.dateStyle = .medium
 print("sucesss!!!")
                print("Reminder data \(authViewModel.getData())")
                print("Reminders \(authViewModel.reminders)")
                authViewModel.addReminder(name: name, date: dateFormatter.string(from: chosenDate), time: "5:45PM", priority: "high", notes: notes)
                authViewModel.getData()
            }, label:{
                Text("Save")
             }))
            .navigationBarItems(leading: Button(action: {
                print("Cancel")
             }, label:{
                Text("Cancel")
            }))
             
        }
    }
}
#Preview {
    NewReminderView()
}
