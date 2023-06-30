import SwiftUI
struct ContentView: View {
    @State private var checked = false
    
    var body: some View {
        SlideButtonView(checked: $checked, checkInAction: {
            if checked{
                print("open")
            }else{
                print("locked")
            }
        }, thumbImage: Image(checked ? "checkedIn" : "checkInIcon"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
