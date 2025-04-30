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
import FirebaseStorage
//import FirebaseStorage
 struct AccountView: View {
    @State private var avatarImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
     @State private var selectedImage: UIImage?
     @State private var imageData: Data = Data()
     @State private var isEditing: Bool = false
     @State private var message: String = "Edit Profile Photo"

    @EnvironmentObject var viewModel: AuthViewModel
     @State var retrievedImages = [UIImage]()
    //guard let image = profileImageView.image else { return }
//     func loadImage(){
//         guard let inputImage = selectedImage else { return }
//         avatarImage = inputImage
//     }

     var body: some View {
          if let user = viewModel.currentUser {
 
             // let storageRef = Storage.storage().reference()
             List{
                 Section{
                     HStack{
                         PhotosPicker(selection: $photosPickerItem, matching: .images){
                             if let avatarImage = self.avatarImage{
                                 Image(uiImage: avatarImage ?? UIImage(resource: .cat2))
                              //   self.persistImageToStorage()
                                     .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 72, height: 72)
                                     .clipShape(.circle)
                             } else{
                                 Image("cat2")
                                 
                                     .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 72, height: 72)
                                     .clipShape(.circle)

                             }
//                             Button {
//                                 print("save")
////                                 uploadPhoto()
//                             } label: {
//                                 Label(message, systemImage: "pawprint.fill")
//                              }
//
                         }
                         //                        if inputImage != nil{
                         //
                         //                        }
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
            .scrollContentBackground(.hidden)
           .background(
                Image("gueinaPig")
                    .resizable()
                    .blur(radius: 3)
                    .scaledToFill()
                     .ignoresSafeArea()

            )

//             .onAppear(){
//                 retrievePhoto()
//
//             }
             //start of photosPicker
             .onChange(of: photosPickerItem) { _, _ in
                 Task{ if let photosPickerItem,
                          let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                     if let image = UIImage(data: data) {
                         avatarImage = image
//                         viewModel.updateProfile(updateProfile: profileURL image.downloadURL)
//                         uploadPhoto()
                     }
                     
                 }
                     photosPickerItem = nil
                 }
             }//end of photosPicker
             
         }
     }
     
     func edit(){
         if isEditing{
             message = "Save Profile Photo"
             isEditing = !isEditing
             
         } else{
             message = "Edit Profile Photot"
             isEditing = !isEditing

         }
     }
//     func persistImageToStorage(){
//         let fileName = UUID().uuidString
//         guard let uid = authView.currentUser?.id
//         else {return}
//       let ref =  Storage.storage().reference(withPath: uid)
//         guard let imageData = self.avatarImage?.jpegData(compressionQuality)
//                ref.putData(imageData, metaData: nil) { metadata, err in if let err = err {
//                    return                 }
//                }
//         ref.downloadURL(){url, err in
//             if let err = err{
//                 return
//             }
//         }
//     }

//     func getProfilePhoto(){
//         avatarImage?.pngData()
//     }
//         func retrievePhoto(){
//
//             let db = Firestore.firestore()
//             db.collection("profilePhoto").getDocuments() {snapshot, error in
//                 if error == nil && snapshot != nil {
//                     var paths = [String]()
//
//                     for doc in snapshot!.documents{
//                         paths.append(doc["url"] as! String)
//                     }
//
//                     for path in paths{
//
//                         let storageRef = Storage.storage().reference()
//
//                         let fileRef = storageRef.child(path)
//
//                         fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//                             if error == nil && data != nil {
//                                 if error == nil {
//                                     let image = UIImage(data: data!)
//                                     DispatchQueue.main.async{
//                                         avatarImage = image
//                                     }
//                                 }
//                             }
//                         }
//                     }
//
//
//                 }
//             }
//         }
         
         
         
//         func uploadPhoto(){
//             let storageRef = Storage.storage().reference()
//
////             let imageData = avatarImage!.jpegData(compressionQuality: 0.8)
//
//             guard imageData != nil else{
//                 return
//             }
//             let path = ("profilePhoto/\(UUID().uuidString).jpg")
//
//
//             let fileRef = storageRef.child(path)
//
//
//             //                let path = "images/\(UUID().uuidString).jpg"
//             //                let fileRef = storageRef.child(path)
//             let uploadTask = fileRef.putData(imageData!, metadata: nil){
//                 metadata, error in
//
//                 if error == nil && metadata != nil {
//
//                     fileRef.downloadURL{ (url, error) in
//                         guard let downloadURL = url else  {
//                             return
//                         }
//                     }
//                 }
//             }
//         }
     }
         //

        //let filename = UUID().uuidString
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid
//        else {return}
//        let ref = FirebaseManager.shared.storage.reference()
//        guard let imageData = self.image?.jpgData(compressionQuality:0.5) else {return}
//        ref.putData(imageData, metadata: nil){metadata, err in
//            if err = err {
//                print("err login")
//                return}
//            ref.downloadURL{url, err in
                
          //  }
            //         guard avatarImage != nil else {
//            return
//        }
//        let storageRef = Storage.storage().reference(withPath: uid)
//
//        let imageData = avatarImage!.jpegData(compressionQuality: 0.8)
//
//        guard imageData != nil else{
//            return
//        }
//        let path = "images/\(UUID().uuidString).jpg"
//        let fileRef = storageRef.child(path)
//        let uploadTask = fileRef.putData(imageData!, metadata: nil){
//            metadata, error in
//
//            if error == nil && metadata != nil {
//                let db = Firestore.firestore()
//                db.collection("images").document().setData(["url": path])
//
           // }
        //}

    //}
       //let (path, name) = try await FileManager.shared.saveImage(data: data)
        //Firestore.Storage.storage(){
            
 
           // print(path)
          //  print(name)
            
        
 
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
