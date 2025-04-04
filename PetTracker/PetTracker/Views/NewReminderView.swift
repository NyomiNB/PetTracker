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
    @ObservedObject var authViewModel = AuthViewModel()
    //    @State private var newPet = ""
    @State var name = ""
    @State var notes = ""
    init(){
        authViewModel.getData()
    }
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("New Reminder")){
                    TextField("Reminder", text: $name)
                    TextField("Notes", text: $notes)
                }
                
            }
            .navigationBarItems(trailing: Button(action: {
                print("sucesss!!!")
                print("Reminder data \(authViewModel.getData())")
                print("Reminders \(authViewModel.reminders)")
                authViewModel.addReminder(name: name, date: "today"
                                          , time: "5:45PM", priority: "high", notes: notes)
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
