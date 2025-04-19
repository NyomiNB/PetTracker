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
        ScrollView(.vertical){
            LazyVStack(spacing: 15){
                CarouselView()
            }
        }
    }
    
    //        ScrollView(.vertical){
    //            LazyVStack(spacing: 15){
    @ViewBuilder
    func CarouselView() -> some View{
        let spaceInt: CGFloat = 10

        NavigationView{
            HStack{
                Text("My Pets")
                    .font(.largeTitle)
                    .bold()
                Image(systemName: "pawprint.fill")
            }
            ScrollView(.horizontal){
//                LazyVStack(spacing: 15){
                HStack(spacing: spaceInt){
 
                    ForEach(authViewModel.pets){pet in
                        NavigationLink(destination: PetDetail(pet:pet)){
                            Image(pet.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                             .clipShape(.circle)
                             .frame(height: 380)

                             //PetRow(pet: pet)
                         }
                        .swipeActions{
                            Button ("Delete"){
                                authViewModel.removePet(removePet: pet)
                            }
                            .tint(.red)
                        }
                    }
                }
            }
            .frame(height: 380)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))

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
}
       // }

            
            //        ScrollView(.vertical){
            //            LazyVStack(spacing: 15){
            //                CarouselView()
            //            }
            
            
            //    @ViewBuilder
            //    func CarouselView() -> some View{
            //         NavigationView{
            //                        List(authViewModel.pets){pet in
            //                            NavigationLink(destination: PetDetail(pet:pet)){
            //                                PetRow(pet: pet)
            //
            //                     List(authViewModel.pets){pet in
            //                        NavigationLink(destination: PetDetail(pet:pet)){
            //                            PetRow(pet: pet)
            //
            //
            //                    }
            //                }
            //                .scrollTargetLayout()
            //            }
            //            .frame(height: 380)
            //            .scrollIndicators(.hidden)
            //            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            //        }
            //    }
            //}
            //                    .onAppear(){
            //                                   self.authViewModel.getData()
            //                               }
            //                               .navigationBarItems(trailing: Button(action: {
            //                                   print("add pet")
            //                               }, label:{
            //                                   NavigationLink(destination: NewPetView()){
            //                                       Image(systemName: "plus")
            //                                   }
            //                               }
            //                                         ))
            //
            //                           }
            //
            //    var body: some View {
            //        NavigationView{
            //            List(authViewModel.pets){pet in
            //                NavigationLink(destination: PetDetail(pet:pet)){
            //                    PetRow(pet: pet)
            //                        .swipeActions{
            //                            Button ("Delete"){
            //                                authViewModel.removePet(removePet: pet)
            //                            }
            //                            .tint(.red)
            //                        }
            //                }
            //            }
            //
            //            .onAppear(){
            //                           self.authViewModel.getData()
            //                       }
            //                       .navigationBarItems(trailing: Button(action: {
            //                           print("add pet")
            //                       }, label:{
            //                           NavigationLink(destination: NewPetView()){
            //                               Image(systemName: "plus")
            //                           }
            //                       }
            //                                 ))
            //
            //                   }
            //               }
            //
            //    //necessary for pets to appear live
            ////        .onAppear(){
            ////            self.authViewModel.getData()
            ////        }
            //    //            .navigationBarItems(trailing: Button(action: {
            //    //                print("add pet")
            //    //            }, label:{
            //    //                NavigationLink(destination: NewPetView()){
            //    //
            //    //                    Image(systemName: "plus")
            //    //
            //    //                }
            //    //            }
            //    //   ))
            //
            //
            //
            
struct PetRow: View{
    let pet: Pet
    var body: some View {
        
        let spaceInt: CGFloat = 10
        ScrollView(.horizontal){
            HStack(spacing: spaceInt){
                Image(pet.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.circle)
                    .frame(height: 380)
                    .containerRelativeFrame(.horizontal)
}
        }
        .frame(height: 380)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))

         //                        }
        //
        //
        //                        .scrollTargetLayout()
        //
        //                    }
        //                    .frame(height: 380)
        //                    .scrollIndicators(.hidden)
        //                    .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
        //
        //
    }
}

#Preview {
    PetView()
}
