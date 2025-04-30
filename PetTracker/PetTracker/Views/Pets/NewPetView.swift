//
//  Home.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/14/25.
//

import SwiftUI
import PhotosUI

struct NewPetView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var avatarImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    @ObservedObject var authViewModel = AuthViewModel()
    //@State private var newPet = ""
    @State var name = ""
    @State var notes = ""
    @State var medications = ""
    @State var healthConditions = ""
    @State var age = ""

    @State var birthdate = ""
    let dateFormatter = DateFormatter()
    @State var birthDate = Date()
    @State var weight = ""
//@State var image = ""
     init(){
        authViewModel.getData()
    }
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    PhotosPicker(selection: $photosPickerItem, matching: .images){
                        Image(uiImage: avatarImage ?? UIImage(resource: .cat2))
                        
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 72, height: 72)
                            .clipShape(.circle)
                    }
                    .onChange(of: photosPickerItem) { _, _ in
                        Task{ if let photosPickerItem,
                                 let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                            if let image = UIImage(data: data) {
                                avatarImage = image
                            }
                            
                        }
                            photosPickerItem = nil
                        }
                        
                    }
                }
                Form{
                    Section(header: Text("Pet Name")){
                        TextField("Pet Name", text: $name)
                        //TODO: Stepper for age or calendar
                        //TODO: Allow user to input pet weight
                    }
                    Section(header: Text("Age")){
                         TextField("Birthday", text: $birthdate)
                        TextField("Age", text: $age)

                        //                    TextField("Image", text: $image)
                    }

                     Section(header: Text("Health")){
                         TextField("Weight", text: $healthConditions)
                        TextField("Medical Conditions", text: $healthConditions)
                        TextField("Medications", text: $medications)
                         TextField("Veternary Office", text: $healthConditions)
                         TextField("Last Vet Visit", text: $healthConditions)

                        //                    TextField("Image", text: $image)
                    }
                    
                    Section(header: Text("Pet Notes")){
                        TextField("Notes", text: $notes)
                        //                    TextField("Image", text: $image)
                    }

                    Section(header: Text("Date")){
                        DatePicker(
                            "Birthday:",
                            selection: $birthDate,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(.compact)
                        }

                }
            }
            .navigationBarItems(trailing: Button(action: {
                print("sucesss?")
                print("Pet data \(authViewModel.getData())")
                print("Pets \(authViewModel.pets)")
                authViewModel.addPet(name: name, birthdate: dateFormatter.string(from: birthDate), age: Int(age) ?? 0, weight: Double(weight) ?? 0, medications: notes, healthConditions: medications, notes:healthConditions)
                    //TODO: Add editable image variable to addpetMethod
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
}
#Preview {
    NewPetView()
}
