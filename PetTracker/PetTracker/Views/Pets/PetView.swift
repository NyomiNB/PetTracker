//
//  PetView.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/19/25.
//

import SwiftUI

struct PetView: View {
    // Pet(id: "d", name: "String", notes: "note")

    @ObservedObject var authViewModel = AuthViewModel()
    //    @State private var showPopup = false
    init(){
        authViewModel.getData()
    }
    var body: some View {
        NavigationView{
            List(authViewModel.pets){pet in
                NavigationLink(destination: PetDetail(pet:pet)){
                    PetRow(pet: pet)
                        .swipeActions{
                            Button ("Delete"){
                                authViewModel.removePet(removePet: pet)
                            }
                            .tint(.red)
                        }
                }
            }
             
            .onAppear(){
                           self.authViewModel.getData()
                       }
                       .navigationBarItems(trailing: Button(action: {
                           print("add pet")
                       }, label:{
                           NavigationLink(destination: NewPetView()){
                               Image(systemName: "plus")
                           }
                       }
                                 ))
                       
                   }
               }
                                             
    //necessary for pets to appear live
//        .onAppear(){
//            self.authViewModel.getData()
//        }
    //            .navigationBarItems(trailing: Button(action: {
    //                print("add pet")
    //            }, label:{
    //                NavigationLink(destination: NewPetView()){
    //
    //                    Image(systemName: "plus")
    //
    //                }
    //            }
    //   ))
        

    
    struct PetRow: View{
        let pet: Pet
        var body: some View {
            
            HStack{
                Text(pet.name)
               // Text(pet.notes)
            }
            }
        }
    }
#Preview {
    PetView()
}
