//
//  AccountView.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/14/25.
//

import SwiftUI
import PhotosUI

struct AccountView: View {
    @State private var avatarImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            List{
                
                Section{
                    HStack{
                        PhotosPicker(selection: $photosPickerItem, matching: .images){
                            Image(uiImage: avatarImage ?? UIImage(resource: .cat2))
                            
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 72, height: 72)
                                .clipShape(.circle)
                        }
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text(user.fullName)
                                .font(.subheadline)
                                .padding(.top, 4)
                                .fontWeight(.semibold)
                            
                            Text(user.email)
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                    }
                }
                Section ("Account") {
                    
                    HStack{
                        Button {
                            print("j")

                            viewModel.signOut()
                         } label: {
                            
                            Label("Sign Out", systemImage: "pawprint.fill")
                            
                        }
                        
                    }
                    HStack{
                        Button {
                            print("j")
                        } label: {
                            
                            Label("Delete Account", systemImage: "pawprint.fill")
                            
                        }
                        
                    }
                    
                }
            }
            //start of photosPicker
            .onChange(of: photosPickerItem) { _, _ in
                Task{ if let photosPickerItem,
                         let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        avatarImage = image
                    }
                    
                }
                    photosPickerItem = nil
                }
            }//end of photosPicker
            
        }
    }//end of if let
}//end of struct


 #Preview {
    AccountView()
}
