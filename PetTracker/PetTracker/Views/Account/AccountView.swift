//
//  AccountView.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/14/25.
//
//TODO: Add weather view
import SwiftUI
import PhotosUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestoreInternal
import FirebaseDatabase
import Firebase
import FirebaseFirestore
 
struct AccountView: View {
    @State private var avatarImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    @EnvironmentObject var viewModel: AuthViewModel
 
    //guard let image = profileImageView.image else { return }
    var body: some View {
//        let storage = Storage.storage()

    if let user = viewModel.currentUser {
       // let storageRef = Storage.storage().reference()
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
                       // uploadPhoto()
                    }
                    
                }
                    photosPickerItem = nil
                }
            }//end of photosPicker
            
        }
     }//end of if let
    func uploadPhoto(data: Data){
             //let (path, name) = try await FileManager.shared.saveImage(data: data)
           // print(path)
          //  print(name)
            
        
    }

    //beggining of saving profile picture
//    func saveProfile(username: String, profileImageURL: URL, completion: @escaping ((_ success: Bool)->()){
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
//        
//        let userObject = [
//            "photoURL": profileImageURL
//        ] as [String: Any]
//        
//        databseRef.setValue(userObject) {error, ref in completion(error == nil)
//            
//        }
//        
//    }//end of saving pfp code
}//end of struct
//start of update pfp func
//func updateProfileImage(_ image:UIImage, completion: @escaping ((_ url: String?)->())){
//    //upload profile image
//    self.uploadProfileImage(image) {url in
//        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//        changeRequest?.photoURL = url
//        
//        changeRequest?.commitChanges { error in
//            if error == nil {
//        print("photo changed")
//                self.saveProfile(username: username, profileURL: url) { success  in
//                    
//                }
//            }
//        }
//    }
    //save to database
    
    //dismiss
    //guard let uid = Auth.auth().currentUser?.uid else { return }
//    let storageRef = Storage.storage().reference().child("user/\(uid)")
//    guard let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
//    let metaData = StorageMetaData()
//    metaData.contentType = "image/jpg"
//    
//    storageRef.putData(imageData, metadata: metaData) {metaData, error in
//        if error == nil, metaData != nil{
//            if let url = metaData?.downloadURL()?.absoluteString{
//                completion(url)
//            }else{
//                print("booo no loading")
//
//                completion(nil)
//            }
// 
//        }
//        print("failed loading")
//    completion(nil)
//    }
//}

 
 #Preview {
    AccountView()
}
