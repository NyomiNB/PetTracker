////
////  ViewModel.swift
////  PetTracker
////
////  Created by Nyomi Bell on 2/19/25.
////
//
//import Foundation
//import Firebase
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseCore
//
//class ViewModel: ObservableObject{
//    @Published var pets: [Pet] = []
//    init(){
//        getData()
//    }
//    func getData(){
//        print("getData View")
//
//        let db = Firestore.firestore()
//        let ref = db.collection("Pets")
//        ref.getDocuments{snapshot, error in
//            guard error == nil else {
//                print(error!.localizedDescription)
//                return
//            }
//            if let snapshot = snapshot{
//                for document in snapshot.documents{
//                    let data = document.data()
//                    
//                    let id = data["id"] as? String ?? ""
//                    let name = data["name"] as? String ?? ""
//                    let notes = data["notes"] as? String ?? ""
//
//                    let pet = Pet(id: id, name: name, age: age, weight: weight, notes: notes)
//                    self.pets.append(pet)
//        
//                }
//            }
//        }
//    }
//}
