//
//  AuthViewModel.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/16/25.
//
//TODO: Fix password authentication
//
//
import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseCore
 
protocol AuthenticationFormProtocol{
    var valid: Bool {get}
}
@MainActor
class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var pets = [Pet]()
    @Published var reminders = [Reminder]()

    init(){
         self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
        
    }
    
    //MARK: Sign In function
    func signIn(withEmail email: String, password: String) async throws{
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
            
        }
    }
    //MARK: Create User
    func createUser(withEmail email: String, password: String, fullname: String) async throws{
        print("createAccount")
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
             try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()

        } catch{
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    //MARK: Sign Out

    func signOut(){
        print("sign out")
        do {
            try Auth.auth().signOut() //signs out user on backend
            self.userSession = nil //wipes out user session and takes ui back to login screen
            self.currentUser = nil //wipes current data model
        }catch{
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    func updateData(updatePet: Pet, name: String, notes: String) {
        //reference to database
        let db = Firestore.firestore()
        
        //get data to update
        db.collection("Pets").document(updatePet.id).setData(["name": name, "notes": notes], merge: true){error in
            if error == nil {
                self.getData()
            }
        }
    }
    //TODO: REMINDER FUNC
    func updateReminder(reminderUpdate: Reminder, name: String, notes: String) {
        //reference to database
        let db = Firestore.firestore()
        
        //get data to update
        db.collection("Pets").document(reminderUpdate.id).setData(["name": name, "notes": notes], merge: true){error in
            if error == nil {
                self.getData()
            }
        }
    }

     //MARK: Delete Account-not functional yet
    func deleteAccount() {
//        do{
//            try await User.delete()
//            print("delete account")
//     
//        }
//        catch{
//            print(error.localizedDescription)
//
//            return false
//        }
        
    }
    //MARK: Remove Pet
    func removePet(removePet: Pet){
        print("remove pet")
        let db = Firestore.firestore()
        db.collection("Pets").document(removePet.id).delete {error in
            if error == nil{
                DispatchQueue.main.async{
                   //remove pet
                    self.pets.removeAll{pet in
                        //check for pet to remove
                        return pet.id == removePet.id
                    }

                }
             } else {
                
            }
        }
        
    }
    
    func removeReminder(removeReminder: Reminder){
        print("remove reminder")
        let db = Firestore.firestore()
        db.collection("Reminders").document(removeReminder.id).delete {error in
            if error == nil{
                DispatchQueue.main.async{
                   //remove pet
                    self.reminders.removeAll{pet in
                        //check for pet to remove
                        return pet.id == removeReminder.id
                    }

                }
             } else {
                
            }
        }
        
    }


    //MARK: Fetch user
    func fetchUser() async{
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else{return}
        self.currentUser = try? snapshot.data(as: User.self)
        
         print("DEBUG: Current user is \(self.currentUser)")
    }
    //MARK: Get Data
    func getData(){
        print("AuthView")

        //get ref to data
        let db = Firestore.firestore()
        //read docs
        db.collection("Reminders")
            .whereField("ownerID", isEqualTo: currentUser?.id).getDocuments{snapshot, error in
            //check for errors
            if error == nil{
                //no errors
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async{
                        //get all docs and create pets
                        self.reminders = snapshot.documents.map{ d in
                            //create item
                            return Reminder(id: d.documentID,
                                       name: d["name"] as? String ?? "",
                                       date: d["date"] as? String ?? "", time: d["time"] as? String ?? "", priority: d["priority"] as? String ?? "", notes: d["notes"] as? String ?? "")
                        }
                    }
                }
                for reminder in self.reminders{
                    print("Reminders in get data\(reminder)")
                }
            } else{
                    //error handler
                print("DEBUG: Current pet is \(self.reminders)")

                }
            }
//PRVENTS USERS FROM SEEING ALL PETS-ONLY DATA THAT MATCHES UID WILL SHOW ON UI
        db.collection("Pets")
            .whereField("ownerID", isEqualTo: currentUser?.id).getDocuments{snapshot, error in
            //check for errors
            if error == nil{
                //no errors
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async{
                        //get all docs and create pets
                        self.pets = snapshot.documents.map{ d in
                            //create item
                            return Pet(id: d.documentID,
                                       name: d["name"] as? String ?? "",
                                       notes: d["notes"] as? String ?? "")
                        }
                    }
                }
                for pet in self.pets{
                    print("Pets in get data\(pet)")
                }
            } else{
                    //error handler
                print("DEBUG: Current pet is \(self.pets)")

                }
            }
      }
                     
    
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
//                    let pet = Pet(id: id, name: name, notes: notes)
//                    self.pets.append(pet)
//                    
//                }
//            }
//            
//        }
    
    //MARK: Add Pet
    func addPet(name: String, notes: String){
        //data ref
        
        //doc collection
        let db = Firestore.firestore()
        db.collection("Pets").addDocument(data: ["name": name, "notes": notes, "ownerID": currentUser?.id]){ error in
            //check for error
            if error == nil{
                //no errors
                self.getData()
                
            }else{
                //error handler
                print("error add")
            }
            
        }
    }
    //MARK: Add Reminder
    func addReminder(name: String, date: String, time: String, priority: String, notes: String){
        //data ref
        
        //doc collection
        let db = Firestore.firestore()
        db.collection("Reminders").addDocument(data: ["name": name, "date": date, "time": time, "priority": priority, "notes": notes, "authorID": currentUser?.id]){ error in
            //check for error
            if error == nil{
                //no errors
                self.getData()
                
            }else{
                //error handler
                print("error add remind")
            }
            
        }
    }

      // reset password
      func resetPassword(email: String)async throws{
          try await Auth.auth().sendPasswordReset(withEmail: email)
      }
 }
