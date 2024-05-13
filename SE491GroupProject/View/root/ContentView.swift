import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var globalSearch: GlobalSearch
    
    @State private var selectedTab: Tab = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabView(selection: $selectedTab) {
                    switch selectedTab {
                    case .home:
                        HomeView()
                    case .category:
                        CategoryView()
                    case .favorite:
                        FavoriteView()
                    case .reservation:
                        ReservationView()
                    case .profile:
                        ProfileView()
                    }
                }
                .overlay(
                    CustomTabBar(selectedTab: $selectedTab)
                    , alignment: .bottom
                )
                .ignoresSafeArea(.all, edges: .bottom)
                .onAppear {
                    globalSearch.combine()
                }
        
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
