//
//  PetDetail.swift
//  PetTracker
//
//  Created by Nyomi Bell on 3/26/25.
//edit pet
//--allow user to edit current pet-completed
//TODO: Add alerts to ensure user wants to delete reminder
//TODO: Improve aesthetics-choose cohesive theme
//TODO: dont allow user to leave textfield blank

import SwiftUI

struct PetDetail: View {
    @ObservedObject var authViewModel = AuthViewModel()
    let pet: Pet
 @State private var isEditing = false
    @State private var trailText = "Edit"
    @State private var trailImage = "pencil"
    @State private var message = ""
    @State private var title =   ""

    @State private var save = false

    @State var name = ""
    @State var notes = ""
    @State var age = 0
    @State var weight = 0.0
    @State var image = "catPlaceholder"
       
      var body: some View {
 
        NavigationStack{
             Form{
 
                 Section(header: Text("Name")){
                    TextField("", text: $name, prompt: Text(pet.name).foregroundColor(.black))
                 }
                Section(header: Text("Notes")){
                    
                    TextField("", text: $notes, prompt: Text(pet.notes).foregroundColor(.black))
                }
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.green)
                Button(action: {
                    print("Deleted")
                    authViewModel.removePet(removePet: pet)
                }, label:{
                    Text("Remove Pet")
                })
            }
             .disabled(isEditing)
         }
        .onAppear(){
           initialize()
            check()
        }
 
            .navigationTitle(title)
 
            .navigationBarItems(trailing:
                                    Button(action:{
                check()
                print(isEditing)
            }, label: {
                Image(systemName: trailImage)
                Text(trailText)

            }
                                          ))

       

        }
    func initialize(){
             title = ("\(pet.name)'s Profile")
     }
        func check(){
            
            if isEditing{
                print(pet.name)
                print(name)

                trailText = "Done"
                trailImage = "checkmark"
                print(trailImage)
                print(trailText)
                title = ("Edit \(pet.name)'s Profile")
 
                isEditing = !isEditing
                
                
            } else if !isEditing{
                print(pet.name)
                print(name)

                title = ("\(pet.name)'s Profile")
                      authViewModel.updateData(updatePet: pet, name: name, age: age, weight: weight, notes: notes, image: image)
 
                 trailText = "Edit"
                trailImage = "pencil"
                message = ""
                print(trailImage)
                print(trailText)
                 isEditing = !isEditing

                
            }

 
    }

    }
#Preview {
    PetDetail(pet: pets[0])
}
