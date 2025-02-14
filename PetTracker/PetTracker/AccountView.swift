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
                PhotosPicker(selection: $photosPickerItem){
                    Image(uiImage: avatarImage ?? UIImage(resource: .cat2))
        
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(.circle)
                }
        
         }
        
    }


#Preview {
    AccountView()
}
