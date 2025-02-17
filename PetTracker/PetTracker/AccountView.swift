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
    
    var body: some View {
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
                    Text(User.MOCK_USER.fullName)
                        .font(.subheadline)
                        .padding(.top, 4)
                        .fontWeight(.semibold)
                    
                    Text(User.MOCK_USER.email)
                        .font(.footnote)
                        .accentColor(.gray)
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
}


#Preview {
    AccountView()
}
