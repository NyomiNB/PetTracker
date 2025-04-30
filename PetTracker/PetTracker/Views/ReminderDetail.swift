//
//  PetDetail.swift
//  PetTracker
//
//  Created by Nyomi Bell on 3/26/25.
//
import SwiftUI
//TODO: Add transitions
//TODO: Create completed view
struct ReminderDetail: View {
    @State private var isEditing = true
    @State private var trailText = "Edit"
    @State private var image = "pencil"
    var measurements: CGFloat = 130
    @Environment(\.dismiss) private var dismiss

    @State var name = ""
    @State var notes = ""
    @State var date = ""
    let dateFormatter = DateFormatter()
    @State var chosenDate = Date()
    //    @State private var showPopup = false
    @ObservedObject var authViewModel = AuthViewModel()
    //@State private var showPopup = false
    let reminder: Reminder
    var body: some View {
        NavigationStack{
            HStack(alignment: .top) {
                Text("My Reminders")
                    .font(.title)
                    .bold()
            }
            ZStack{
                Form{
                     Section(header: Text("Name")){
                        TextField("", text: $name, prompt: Text(reminder.name).foregroundColor(.black))
                    }
                    Section(header: Text("date")){
                         Text(reminder.date)

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
                    
                }
                
            }
            
            .disabled(isEditing)
            Button(action: {
                print("Deleted")
                authViewModel.removeReminder(removeReminder: reminder)
                dismiss()
     }, label:{
                Text("Remove Reminder")
             })

            }
    
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
    func check(){
        print(chosenDate)
        
        if isEditing{
            self.authViewModel.getData()

            trailText = "Done"
            image = "checkmark.circle"
            print(image)
            print(trailText)
            isEditing = !isEditing
         } else if !isEditing{
             self.authViewModel.getData()

                   if name == "" {
                     name = reminder.name
 
                 }
             if notes == "" {
                     notes = reminder.notes

                 }
             authViewModel.updateReminder(reminderUpdate: reminder, name: name, notes: notes, date: dateFormatter.string(from: chosenDate))


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
