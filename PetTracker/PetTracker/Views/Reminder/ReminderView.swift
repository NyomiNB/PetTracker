import SwiftUI
import CoreData

struct ReminderView: View {
    var measurements: CGFloat = 130
    @State private var searchText = ""
    
    @ObservedObject var authViewModel = AuthViewModel()
    //    @State private var showPopup = false
    init(){
        authViewModel.getData()
        UIListContentView.appearance().backgroundColor = .red
    }
    var filteredReminders: [Reminder] {
        guard !searchText.isEmpty else { return authViewModel.reminders }
        return authViewModel.reminders.filter {$0.name.localizedCaseInsensitiveContains(searchText)}
    }
    
    //    @State private var activeTab: TabItem = .home
    var body: some View {
        
        // MARK: NavigationView
              NavigationStack{
                
                VStack{
                    
                    List(filteredReminders){reminder in
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
                    .scrollContentBackground(.hidden)
                    .background(
                        Image("blueCat")
                            .blur(radius: 3)
                    )
                }
                .navigationTitle("My Reminders")                .navigationBarItems(trailing: Button(action: {
                    print("add reminder")
                }, label:{
                    NavigationLink(destination: NewReminderView()){
                        Image(systemName: "plus").foregroundColor(.white)
                    
                    }
                }
                                                     
                                                    ))
            
        }
            
            .onAppear(){
                self.authViewModel.getData()
            }
         
    
            .searchable(text: $searchText, prompt: "Search Reminders")
            
            
        }
        // }
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

    #Preview {
        ReminderView()
    }


