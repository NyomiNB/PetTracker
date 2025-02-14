//
//  ContentView.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/13/25.
//

import SwiftUI
import CoreData

struct HomeView: View {
    //    @State private var activeTab: TabItem = .home
    var body: some View {
        TabView{
            Text("Home").tabItem { Text("Home")
                Image(systemName: "house")}.tag(1)
  
            NewPetView()
                .tabItem{
                    Image(systemName: "pawprint.fill")
                    Text("Add Pet")
                }
            AccountView()
                .tabItem{
                     Image(systemName: "person.crop.circle.fill")
                    Text("My Account")
                    
                }
        }
    }
}
//        ZStack(alignment: .bottom){
//            if #available(iOS 18, *){
//                TabView(selection: $activeTab){
//                    ForEach(TabItem.allCases, id: \.rawValue){ tab in
//                        Tab.init(value: tab){
//                            Text(tab.rawValue)
//                                .toolbarVisibility(.hidden, for: .toolbar)
//                            InteractiveToolBar(activeTab: $activeTab)
//                        }
//                    }
//                }
//            } else {
//                    TabView(selection: $activeTab){
//                        ForEach(TabItem.allCases, id: \.rawValue){ tab in
//                                 Text(tab.rawValue)
//                                    .toolbarVisibility(.hidden, for: .toolbar)
//                                    .tag(tab)
//                            
//                                    .toolbar(.hidden, for: .toolbar)
//                            }
//                            
//                        }
//                    }
//            struct InteractiveToolBar: View{
//                @Binding var activeTab: TabItem?
//                var body: some View{
//                    HStack(spacing: 0){
//                        ForEach(TabItem.allCases, id: \.rawValue) { tab in
//                            
//                        TabButton(tab)
//                        }
//                    }
//                }
//                @ViewBuilder
//                func TabButton(_tab: TabItem) -> some View{
//                    let isActive = activeTab == tab
//                    VStack(spacing: 6) {
//                        Image(systemName: tab.symbolImage)
//                            .symbolVariant(.fill)
//                            .frame(width: isActive ? 50 : 25, height: isActive ? 50 : 25)
//                            .frame(width: 25, height: 25, alignment: .bottom)
//                        
//                    }
                    
            
//
//            }
//        }
//    }

 

#Preview {
    HomeView()
        //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

//enum TabItem: String, CaseIterable{
//case home: "Home"
//case pets: "Pets"
//case settings: "Settings"
//    
//    var symbolImage: String{
//        switch self{
//        case .home: "house"
//        case .pets: "bell"
//        case .settings: "bell"
//}
//    }
//
//}
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
