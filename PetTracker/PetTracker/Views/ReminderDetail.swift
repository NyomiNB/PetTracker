//
//  PetDetail.swift
//  PetTracker
//
//  Created by Nyomi Bell on 3/26/25.
//
 import SwiftUI

struct ReminderDetail: View {
    @State private var isEditing = false
    @State private var trailText = "Edit"
    @State private var image = "pencil"

    @State var name = ""
    @State var notes = ""

    //    @State private var showPopup = false
    @ObservedObject var authViewModel = AuthViewModel()
    //    @State private var showPopup = false
      let reminder: Reminder
    var body: some View {
 
        NavigationStack{
            Form{
                Section(header: Text("Name")){
                    TextField(reminder.name, text: $name).foregroundColor(.black)
                    TextField(reminder.notes, text: $notes).foregroundColor(.black)
 
                    Button(action: {
                        print("SAVED")
                        authViewModel.updateReminder(reminderUpdate: reminder, name: name, notes: notes)
                     }, label:{
                        Text("Save")
                    })
                 }
                
            }
            .disabled(isEditing)
            .navigationBarItems(trailing:
                                    Button(action:{
                check()
  print(isEditing)
            }, label: {
                    Image(systemName: image)
                }
                                          ))
            
        }
 
     }
    func check(){
        if isEditing{
            trailText = "Edit"
            image = "pencil"
            print(image)
            print(trailText)

        } else if !isEditing{
            trailText = "Done"
            image = "checkmark"
            print(image)
            print(trailText)

        }

    }

    }
#Preview {
    ReminderDetail(reminder: reminders[0])
}
