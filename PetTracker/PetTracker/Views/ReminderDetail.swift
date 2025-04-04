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
