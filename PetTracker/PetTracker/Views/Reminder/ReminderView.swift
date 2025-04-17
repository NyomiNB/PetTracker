import SwiftUI
import CoreData

struct ReminderView: View {
    @ObservedObject var authViewModel = AuthViewModel()
    //    @State private var showPopup = false
    init(){
        authViewModel.getData()
    }
    
    //    @State private var activeTab: TabItem = .home
    var body: some View {
        
        // MARK: NavigationView
        
        NavigationView{
            List(authViewModel.reminders){reminder in
                NavigationLink(destination: ReminderDetail(reminder:reminder)){
                    ReminderRow(reminder: reminder)
                        .swipeActions{
                            Button ("Delete"){
                                authViewModel.removeReminder(removeReminder: reminder)
                            }
                            .tint(.red)
                        }
                }
            }
            .onAppear(){
                self.authViewModel.getData()
            }
            .navigationBarItems(trailing: Button(action: {
                print("add reminder")
            }, label:{
                NavigationLink(destination: NewReminderView()){
                    Image(systemName: "plus")
                }
            }
                                                ))
        }
    }
    
    struct ReminderRow: View{
        let reminder: Reminder
        var body: some View {
            
            HStack{
                Text(reminder.name)
                Text(reminder.date)

            }
        }
    }
}
    #Preview {
        ReminderView()
    }


