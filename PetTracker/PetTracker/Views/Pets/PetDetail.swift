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
//TODO: Add messages to user
//TODO: calc age based on birthday

import SwiftUI

struct PetDetail: View {
    @ObservedObject var authViewModel = AuthViewModel()
    let pet: Pet
 @State private var isEditing = false
    @State private var trailText = "Edit"
    @State private var trailImage = "pencil.circle"
    @State private var message = ""
    @State private var title =   ""
    @State private var clicked = false

    @State private var save = false

    @State var name = ""
    @State var notes = ""
    @State var age = 0
    @State var weight = 0.0
    @State var image = "catPlaceholder"
       
      var body: some View {
 
        NavigationStack{
            HStack{
                Image(pet.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(50)
             }
            VStack(alignment: .leading){
                if name != "" {
                    Text(name)
                        .font(.title2)
                        .bold()

                } else {
                    Text(pet.name)
                        .font(.title2)
                        .bold()

                }
            
             }


             Form{
 
                 Section(header: Text("Name")){
                    TextField("", text: $name, prompt: Text(pet.name).foregroundColor(.black))
                 }
                Section(header: Text("Notes")){
                    
                    TextField("", text: $notes, prompt: Text(pet.notes).foregroundColor(.black))
                }
             }
             .disabled(isEditing)
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
        .onAppear(){
           initialize()
            check()
        }
 
            .navigationBarItems(trailing:
                                    Button(action:{
                check()
                print(isEditing)
            }, label: {
                Image(systemName: trailImage)
                Text(trailText)

            }
                                          ))
            .navigationTitle(title)
 
       

        }
    func initialize(){
        if name == ""{
            title = ("\(pet.name)'s Profile")
            
        } else {
            title = ("\(name)'s Profile")
        }
    }
        func check(){
            
            if isEditing{
                clicked = true
                print("Pet NAme\(pet.name)")
                      print("Name\(name)")

                trailText = "Done"
                trailImage = "checkmark.circle"
                print(trailImage)
                print(trailText)
                
                if name == ""{
                    title = ("Edit \(pet.name)'s Profile")

                } else {
                     title = ("Edit \(name)'s Profile")
              }

                isEditing = !isEditing
                message =  ""
                
            } else if !isEditing{
                print("Pet NAme\(pet.name)")
                      print("Name\(name)")
                
                if name != ""{
                    
                    authViewModel.updateData(updatePet: pet, name: name, age: age, weight: weight, notes: notes, image: image)
                 }
                if name == ""{
                    title = ("\(pet.name)'s Profile")

                } else {
                     title = ("\(name)'s Profile")
              }

 
                 trailText = "Edit"
                trailImage = "pencil.circle"
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
