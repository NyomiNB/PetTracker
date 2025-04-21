//
//  PetView.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/19/25.
//
//TODO: Add search bar to search for pets
import SwiftUI

struct PetView: View {
    // Pet(id: "d", name: "String", notes: "note")
    @Environment(\.verticalSizeClass) var verticalSizeClass
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
            VStack{
                
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
                                // .aspectRatio(contentMode: .fill)
                                    .clipShape(.circle)
                                    .overlay(Circle().stroke(Color.green))
                                    .containerRelativeFrame(.horizontal, count: verticalSizeClass == .regular ? 1 : 4, spacing: 16)
                                    .frame(height: 380)
                                    .scrollTransition{content, phase in content
                                            .opacity(phase.isIdentity ? 1.0: 0.2)
                                            .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3, y: phase.isIdentity ? 1.0 : 0.3  )
                                            .offset( y: phase.isIdentity ? 0 : 50)
                                    }
                                
                                    .overlay(alignment: .bottom){
                                        OverlayView(pet)
                                    }
                                //)
                            }
                        }
                        //
                    }
                }
                .scrollTargetLayout()
                .frame(height: 380)
                .scrollIndicators(.hidden)
                .contentMargins(16, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
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
    }

@ViewBuilder
func OverlayView(_ pet: Pet) -> some View{
    //HStack(alignment: .bottom, spacing: 30, content: {
              Text(pet.name)
                .font(.title2)
                .bold()
    }
    //   .padding([.leading, .bottom], 2)

   
            
//struct PetRow: View{
//    let pet: Pet
//    var body: some View {
//        
//        let spaceInt: CGFloat = 10
//        ScrollView(.horizontal){
//            HStack(spacing: spaceInt){
//                Image(pet.image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .clipShape(.circle)
//                    .frame(height: 380)
//                    .containerRelativeFrame(.horizontal)
//}
//        }
//        .frame(height: 380)
//        .scrollIndicators(.hidden)
//        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))

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
   // }
//}

#Preview {
    PetView()
}
