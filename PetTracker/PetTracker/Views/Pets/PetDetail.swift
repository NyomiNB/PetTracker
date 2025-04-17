//
//  PetDetail.swift
//  PetTracker
//
//  Created by Nyomi Bell on 3/26/25.
//edit pet
//--allow user to edit current pet-completed
//TODO: Add alerts to ensure user wants to delete reminder
//TODO: Improve aesthetics-choose cohesive theme
import SwiftUI

struct PetDetail: View {
    @State private var isEditing = false
    @State private var trailText = "Edit"
    @State private var image = "pencil"

    @State var name = ""
    @State var notes = ""

    //    @State private var showPopup = false
    @ObservedObject var authViewModel = AuthViewModel()
    //    @State private var showPopup = false
    let pet: Pet
    var body: some View {
 
        NavigationStack{
            Form{
                Section(header: Text("Name")){
                    TextField(pet.name, text: $name).foregroundColor(.black)
                    TextField(pet.notes, text: $notes).foregroundColor(.black)
 
//                    Button(action: {
//                        print("SAVED")
//                        authViewModel.updateData(updatePet: pet, name: name, notes: notes)
//                    }, label:{
//                        Text("Save")
//                    })
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
            trailText = "Done"
            image = "checkmark"
            print(image)
            print(trailText)

                           authViewModel.updateData(updatePet: pet, name: name, notes: notes)
            isEditing = !isEditing


        } else if !isEditing{
            trailText = "Edit"
            image = "pencil"
            print(image)
            print(trailText)

 
        }

    }

    }
#Preview {
    PetDetail(pet: pets[0])
}
