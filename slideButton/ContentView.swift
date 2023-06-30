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

//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Hello, SwiftUI!")
//                .foregroundColor(.white)
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .overlay(
//                   RoundedRectangle(cornerRadius: 15)
//                       .stroke(Color.black, lineWidth: 1)
//               )
//        .frame(height: 100)
//        .background(Color.red)
//        .cornerRadius(15)
//        .padding(25)
//
//
//    }
//}
