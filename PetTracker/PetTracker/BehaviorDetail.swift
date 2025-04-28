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

     @State private var isEditing = false
    @State private var trailText = "Edit"
    @State private var image = "pencil"

    @State var name = ""
    @State var notes = ""
    @State var date = ""
     @State var pet = "Select Pet"

    @State var time = ""
     let dateFormatter = DateFormatter()
     @State var chosenDate = Date()
@State private var selectedPet = ""
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
                Section(header: Text("Pet")){
                    Picker("Pet", selection: $pet){
                        ForEach(authViewModel.pets){pet in
                            Text(pet.name)
                        }
                    }
                    .pickerStyle(.navigationLink)
                  }

                DatePicker(
                    "Date",
                    selection: $chosenDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.graphical)

                Button(action: {
                    print("SAVED")
                    
                    authViewModel.updateDeed(updateDeed: deed, pet: pet, name: name,   date: dateFormatter.string(from: Date.now), time: time, notes: notes)
                 }, label:{
                    Text("Save")
                })

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
 BehaviorDetail(deed: deeds[0])
 }
