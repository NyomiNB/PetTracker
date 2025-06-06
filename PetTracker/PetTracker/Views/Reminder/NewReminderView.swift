//  NewPetView 2.swift
//  PetTracker
//
//  Created by Nyomi Bell on 4/4/25.
//  Home.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/14/25.
//

import SwiftUI

struct NewReminderView: View {
    var measurements: CGFloat = 130

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
//        ZStack{
//            Circle().fill(.blue.opacity(0.1))
//            Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 60, y: 140)
//            Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 340, y: 140)
//            Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 210, y: 100)//middle
 
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
                    dismiss()

                }, label:{
                    Text("Save")
                }))
 
                .navigationBarItems(leading: Button(action: {
                    dismiss()
                }, label:{
                    Text("Cancel")
                }))
 
            }
            .navigationBarBackButtonHidden()
         }
    //}
}
#Preview {
    NewReminderView()
}
