//
//  PetView.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/19/25.
//
//TODO: Improve aestetics
//TODO: Allow user to choose profile photo for pet
//TODO: Have UI read "No Pets Found" when no matching searches
import SwiftUI

struct PetView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @ObservedObject var authViewModel = AuthViewModel()
    @State private var listView = false
@State private var searchText = ""
    var measurements: CGFloat = 130

 //    @State private var showPopup = false
 
   init(){
        authViewModel.getData()
    }
    var filteredPets: [Pet] {
        guard !searchText.isEmpty else { return authViewModel.pets }
         return authViewModel.pets.filter {$0.name.localizedCaseInsensitiveContains(searchText)}
    }

    var body: some View {
 
            if listView{
                ZStack{
                    Circle().fill(.blue.opacity(0.1))
                    Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 60, y: 140)
                    Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 340, y: 140)
                    Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 210, y: 100)//middle
                    
                    NavigationView{
                        List(filteredPets){pet in
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
                        .navigationBarItems(leading: Button(action: {
                            print("editView")
                            listView = !listView
                        }, label:{
                            Image(systemName: "circlebadge")
                            Text("Carousel View")
                        }
                                                           ))
                        
                        .searchable(text: $searchText, prompt: "Search Pets")
                        .navigationTitle("My Pets")
                        .navigationBarTitleDisplayMode(.inline)
                        
                        .scrollContentBackground(.hidden)
                                        .background(
                                            Image("catPicture")
                                                .blur(radius: 3)
                                        )
                        
                    }
                }
            
            }else{
            ZStack{
                Color.pink
                
                ScrollView(.vertical){
                    LazyVStack(spacing: 15){
                        CarouselView()
                    }
                }
            }
        }
     }
    
     @ViewBuilder
    func CarouselView() -> some View{
        
        let spaceInt: CGFloat = 10
        
        NavigationView{
           // ZStack{
                //background()
 
                 VStack{
                     ScrollView(.horizontal){
                         HStack(spacing: spaceInt){
                            
                            ForEach(filteredPets){pet in
                                NavigationLink(destination: PetDetail(pet:pet)){
                                    Image(pet.image)
                                        .resizable()
                                         .clipShape(.circle)
                                        .overlay(Circle().stroke(Color.indigo))
                                         .containerRelativeFrame(.horizontal, count: verticalSizeClass == .regular ? 1 : 4, spacing: 16)
                                        .frame(height: 350)
                                        .scrollTransition{content, phase in content
                                                .opacity(phase.isIdentity ? 1.0: 0.2)
                                                .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3, y: phase.isIdentity ? 1.0 : 0.3  )
                                                .offset( y: phase.isIdentity ? 0 : 50)
                                        }
                                    
                                        .overlay(alignment: .bottom){
                                                  OverlayView(pet)
                                                .offset(x: -100, y: -145)

                                         }
                                    //)
                                }
                            }
                            //
                        }
                   // }
                    .scrollTargetLayout()
                    .frame(height: 380)
                    .scrollIndicators(.hidden)
                    .contentMargins(16, for: .scrollContent)
                         .scrollTargetBehavior(.viewAligned(limitBehavior: .always))                }
                     .scrollContentBackground(.hidden)
                                     .background(
                                         Image("catPicture")
                                             .blur(radius: 3)
                                     )

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
                 .navigationBarItems(leading: Button(action: {
                    print("editView")
                    listView = !listView
                }, label:{
                     Image(systemName: "line.horizontal.3")
                    Text("List View")

                    }
                                                    ))
                 .searchable(text: $searchText, prompt: "Search Pets")

                
                 }
                .overlay(
                Paw()
                    .padding(.trailing, 20)
                    .offset(x: -300, y: -1000),
                alignment: .centerFirstTextBaseline)
                  .navigationTitle("My Pets")
                  .navigationBarTitleDisplayMode(.inline)

 
        }
    }
}

@ViewBuilder
func OverlayView(_ pet: Pet) -> some View{
    Text(pet.name)
    
        .font(.largeTitle)
        .bold()
}

struct Paw: View{
    var body: some View {
        
        Image(systemName: "pawprint.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .clipShape(Circle())
    }
}
//@ViewBuilder
//func background() -> some View{
//    var measurements: CGFloat = 130
//
//    Circle().fill(.blue.opacity(0.1))
//    Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 60, y: 140)
//    Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 340, y: 140)
//    Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 210, y: 100)//middle
//}

               struct PetRow: View{
                   let pet: Pet
                   var body: some View {
                       
                       HStack{
                           Text(pet.birthdate)

                           Text(pet.name)
                          // Text(pet.notes)
                       }
                       }
                   }

#Preview {
    PetView()
}
