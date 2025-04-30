//
//  PetDetail.swift
//  PetTracker
//
//  Created by Nyomi Bell on 3/26/25.
//
//--allow user to edit current pet-completed
//TODO: Add alerts to ensure user wants to delete reminder
//TODO: Improve aesthetics-choose cohesive theme
import SwiftUI

struct BehaviorDetail: View {
    //@Binding var rootActive: Bool
    
    @State private var isEditing = true
    @State private var trailText = "Edit"
    @State private var image = "pencil"
    
    @State var name = ""
    @State var notes = ""
    @State var date = ""
    @State var petSelection = "Select Pet"
    
    @State var time = ""
    let dateFormatter = DateFormatter()
    @State var chosenDate = Date()
    @State private var pet = ""
    //    @State private var showPopup = false
    @ObservedObject var authViewModel = AuthViewModel()
    //    @State private var showPopup = false
    let deed: Deed
    var body: some View {
        
        NavigationStack{
            Form{
                Section(header: Text("Name of Behavior")){
                    TextField(deed.name, text: $name).foregroundColor(.black)
                }
                Section(header: Text("Notes")){
                    TextField(deed.notes, text: $notes).foregroundColor(.black)
                }
//                Section(header: Text("Pet")){
//                    TextField(deed.pet, text: $pet).foregroundColor(.black)
//
//
//                }
                Section(header: Text("Date and Time")){
                    
                    
                    DatePicker(
                        "Date",
                        selection: $chosenDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.compact)
                }
            }
            .disabled(isEditing)
        
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
        date = dateFormatter.string(from: chosenDate)
print("date\(date)")
        if isEditing{
            trailText = "Done"
            image = "checkmark.circle"
            print(image)
            print(trailText)
            print("ise ediitng date\(date)")

            isEditing = !isEditing
            
        } else if !isEditing{
            print("is not ediitng date\(date)")

            if name == "" {
                name = deed.name
                
            }
            if notes == "" {
                notes = deed.notes
                
            }
            date = dateFormatter.string(from: chosenDate)
            authViewModel.updateDeed(updateDeed: deed, pet: pet, name: name, date: date, time: time, notes: notes)
            
            
            trailText = "Edit"
            image = "pencil"
            print(image)
            print(trailText)
            isEditing = !isEditing
        }
        
    }
    
    
 
}
#Preview {
    BehaviorDetail(deed: deeds[0])
}
