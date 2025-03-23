//
//  PetView.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/19/25.
//

import SwiftUI

struct PetView: View {
    
    @ObservedObject var authViewModel = AuthViewModel()
    //    @State private var showPopup = false
    init(){
        authViewModel.getData()
    }
    var body: some View {
 
        NavigationView{
            List{
                ForEach(authViewModel.pets){item in
                    HStack{
                         Text(item.name)
                        Spacer()
                        Button(action:{
                            authViewModel.removePet(removePet: item)
                            print("remove pet")
                        }, label:{
                            Image(systemName: "minus")
                            
                        })
                    }
                }
                
            }
            .navigationTitle("My Pets")
           //necessary for pets to appear live
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

#Preview {
    PetView()
}
