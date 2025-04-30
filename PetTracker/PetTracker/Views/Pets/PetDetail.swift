//
//  PetDetail.swift
//  PetTracker
//
//  Created by Nyomi Bell on 3/26/25.
//edit pet
//--allow user to edit current pet-completed
//TODO: Add alerts to ensure user wants to delete reminder
//TODO: dont allow user to leave name and species textfield blank
//TODO: Add insurance
//TODO: Add medications
//TODO: Add insurance info
//TODO: calc age based on birthday
//TODO: Add messages to user
//TODO: Improve aesthetics-choose cohesive theme

import SwiftUI

struct PetDetail: View {
    @ObservedObject var authViewModel = AuthViewModel()
    @Environment(\.dismiss) private var dismiss
    var measurements: CGFloat = 130
    let pet: Pet
 @State private var isEditing = true
    @State private var trailText = "Edit"
    @State private var trailImage = "pencil.circle"
    @State private var message = ""
    @State private var title =   ""
    @State private var birthdate =   ""
    @State private var medications =   ""
    @State private var healthConditions =   ""

    @State private var dateYear = DateComponents()
    @State private var dateMonth = DateComponents()
    @State private var dateDay = DateComponents()
    @State private var dateHours = DateComponents()
 let format =  DateFormatter()

    @State private var ageMessage = ""

    @State private var clicked = false
    let dateFormatter = DateFormatter()
    @State var day = Date()
 
    @State private var save = false

    @State var name = ""
    @State var notes = ""
    @State var age = ""
    @State var weight = ""
    @State var image = "catPlaceholder"
    @State var Months = 0
    @State var Days = 0
    @State var Years = 0
    @State var Hours = 0

      var body: some View {
 
          NavigationStack{
              ZStack{
                  Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 60, y: 140)
        Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 340, y: 150)
         Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 210, y: 100)//middle

                  VStack{
                      HStack(alignment: .center){
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
                                  .disabled(isEditing)
                          }
                          Section(header: Text("Weight")){
                              TextField("", text: $weight, prompt: Text(String(pet.weight)).foregroundColor(.black))
                              
                                  .disabled(isEditing)
                          }
                          Section(header: Text("Medications")){
                              TextField("", text: $medications, prompt: Text(pet.medications).foregroundColor(.black))
                                  .disabled(isEditing)
                              
                          }
                          Section(header: Text("Health Conditions")){
                              TextField("", text: $healthConditions, prompt: Text(pet.healthConditions).foregroundColor(.black))
                                  .disabled(isEditing)
                              
                          }
                          
                          
                          Section(header: Text("Notes")){
                              
                              TextField("", text: $notes, prompt: Text(pet.notes).foregroundColor(.black))
                                  .disabled(isEditing)
                          }
                          Section(header: Text("Age")){
                              TextField("", text: $age, prompt: Text(String(pet.age)).foregroundColor(.black))
                          }
                          
                          //                 Section(header: Text("Birthday:\(pet.birthdate)")){
                          //                     DatePicker(
                          //                         "Date:",
                          //                         selection: $day,
                          //                         displayedComponents: [.date, .hourAndMinute]
                          //                     )
                          //                     .datePickerStyle(.compact)
                          //                        .disabled(isEditing)
                          //                    }
                      }
                      // .scrollContentBackground(.hidden)
                  }
              }
                  .onAppear(){
                      initialize()
                  }
                  
                  //            Text(message)
                  //             .font(.subheadline)
                  //             .foregroundColor(.green)
                  Button(action: {
                      print("Deleted")
                      authViewModel.removePet(removePet: pet)
                      dismiss()
                  }, label:{
                      Text("Remove Pet")
                  })
                  
              }
              .navigationBarItems(trailing:
                                    Button(action:{
                  //                 format.dateStyle = .medium
                  check()
                  
                  
                  print(Months)
                  
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
//    func calendar(){
//        dateYear = Calendar.current.dateComponents([.year], from: day, to: Date.now)
//        dateMonth = Calendar.current.dateComponents([.month], from: day, to: Date.now)
//        dateDay = Calendar.current.dateComponents([.day], from: day, to: Date.now)
//        dateHours = Calendar.current.dateComponents([.hour], from: day, to: Date.now)
//        Months = dateMonth.month!
//        Days = dateDay.day!
//        Years = dateYear.year!
//        Hours = dateHours.hour!
//        if Years > 0{
//            ageMessage = "\(Years) Years Old"
//
//        } else if Months > 0{
//            ageMessage = "\(Months) Months Old"
//
//        } else if Days > 0{
//            ageMessage = "\(Days) Days Old"
//        }else {
//            ageMessage = "Less Than a Day Old"
//
////                } else if Hours > 0{
////                    ageMessage = "\(Hours) Hours Old"
////
////                } else {
////                    ageMessage = "Less than an hour old"
//
//        }
//
  //  }
        func check(){
            
            if isEditing{
//                print("Birth Date \(birthDate)")
            print("Birth date \(birthdate)")

 
                print(Months)
//                 print(birthDate)
//                print(birthDate)

                clicked = true
                print("Pet Name\(pet.name)")
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
               // calendar()

                print("Birth Date \(day)")
                print("Birth date \(birthdate)")

                 print("Birth Date \(day)")
                print("Birth date \(birthdate)")

  
                print("Pet NAme\(pet.name)")
                      print("Name\(name)")
                
                if name != "" && notes != ""{
                    title = ("\(name)'s Profile")

                    authViewModel.updateData(updatePet: pet, name: pet.name, birthdate: format.string(from: day), age: Int(age) ?? 0, weight: Double(weight) ?? 0.0, notes: notes, medications: medications, healthConditions: healthConditions, image: image)
                    print("Birth date \(birthdate)")

                 } else if name == "" && notes != ""{
                    title = ("\(pet.name)'s Profile")
                     authViewModel.updateData(updatePet: pet, name: pet.name, birthdate: format.string(from: day), age: Int(age) ?? 0, weight: Double(weight) ?? 0.0, notes: notes, medications: medications, healthConditions: healthConditions, image: image)
                     print("Birth date \(birthdate)")


                 } else if notes == "" && name != ""{
                     title = ("\(name)'s Profile")

                     authViewModel.updateData(updatePet: pet, name:  name, birthdate: format.string(from: day), age: Int(age) ?? 0, weight: Double(weight) ?? 0.0, notes: pet.notes, medications: medications, healthConditions: healthConditions, image: image)
                     print("Birth date \(birthdate)")


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
