////
////  EditPetView.swift
////  PetTracker
////
////  Created by Nyomi Bell on 4/1/25.
////
//
//import SwiftUI
//
//struct EditPetView: View {
// 
//    @ObservedObject var authViewModel = AuthViewModel()
//    @Environment(\.presentationMode) var presentationMode
//    //    @State private var newPet = ""
//    @State var name = ""
//    @State var notes = ""
//    init(){
//        authViewModel.getData()
//    }
//    var body: some View {
//        NavigationView{
//            Form{
//                Section(header: Text("Name")){
//                    TextField("Name!", text: $name)
//                }
//                Section(header: Text("Notes")){
//                    TextField("Notes!", text: $notes)
//                    
//                }
//            }
//            .navigationBarTitle("EditPet", displayMode: .inline)
//            .navigationBarItems(
//                leading: Button(action:{dismiss()}, label: {
//                    Text("Back")
//                }),
//                trailing: Button(action:{authViewModel.updateData(updatePet: pet)}, label: {
//                    Text("Save")
//                })
//            )
//        }
//    }
//    func handlCancelTapped(){
//        
//    }
//    func handleDoneTapped(){
//        dismiss()
//    }
//    func dismiss(){
//        presentationMode.wrappedValue.dismiss()
//    }
//}
//
//
//
////            VStack{
////                TextField("New Pet", text: $name)
////                TextField("Notes", text: $notes)
////
////                Button{
////                    //add pet
////                    authViewModel.addPet(name: name, notes: notes)
////      //clear fields
////       print("sucesss?")
////                    print("Pet data \(authViewModel.getData())")
////                    print("Pets \(authViewModel.pets)")
////
////                    name = ""
////                    notes = ""
////                    authViewModel.getData()
////
////                } label: {
////                    Text("Save")
////                }
////            }
////            .padding()
////        }
//    
//#Preview {
//    EditPetView()
//}
