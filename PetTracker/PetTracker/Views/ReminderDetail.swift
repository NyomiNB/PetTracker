//
//  PetDetail.swift
//  PetTracker
//
//  Created by Nyomi Bell on 3/26/25.
//
 import SwiftUI

struct ReminderDetail: View {
    @State private var isEditing = true
    @State private var trailText = "Edit"
    @State private var image = "pencil"

    @State var name = ""
    @State var notes = ""
    @State var date = ""
    let dateFormatter = DateFormatter()
    @State var chosenDate = Date()
     //    @State private var showPopup = false
    @ObservedObject var authViewModel = AuthViewModel()
    //    @State private var showPopup = false
      let reminder: Reminder
    var body: some View {
         NavigationStack{
            Form{
                Section(header: Text("Name")){
                    TextField("", text: $name, prompt: Text(reminder.name).foregroundColor(.black))
                }
                Section(header: Text("Notes")){
                    
                    TextField("", text: $notes, prompt: Text(reminder.notes).foregroundColor(.black))
                }
                Section(header: Text("Date")){ 
                    DatePicker(
                        "Date",
                        selection: $chosenDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.compact)
                }
//                    Button(action: {
//                        print("SAVED")
//                        authViewModel.updateReminder(reminderUpdate: reminder, name: name, notes: notes, date: dateFormatter.string(from: chosenDate))
//                     }, label:{
//                        Text("Save")
//                    })
                 
                
            }
            .disabled(isEditing)
            .navigationBarItems(trailing:
                      Button(action:{
                dateFormatter.dateStyle = .medium
check()
print(isEditing)
            }, label: {
                    Image(systemName: image)
                Text(trailText)
                 }
                                          ))
 
            
        }
 
     }
    func check(){
        if isEditing{
            trailText = "Done"
                       image = "checkmark.circle"
                       print(image)
                       print(trailText)
             isEditing = !isEditing

        } else if !isEditing{
            if name != "" {
                authViewModel.updateReminder(reminderUpdate: reminder, name: name, notes: notes, date: dateFormatter.string(from: chosenDate))
            }
            trailText = "Edit"
            image = "pencil"
            print(image)
            print(trailText)
 isEditing = !isEditing
        }

    }

    }
#Preview {
    ReminderDetail(reminder: reminders[0])
}
