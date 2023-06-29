import SwiftUI

struct SlideToUnlockButton: View {
    @State private var xOffset: CGFloat = 0
    @State private var unlocked = false
    @State private var height: CGFloat = 60
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    if xOffset >= 200 {
                        Text("Unlocked")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .transition(.opacity)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    } else {
                        Text("Slide to Unlock")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .transition(.opacity)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                    
                    Circle()
                        .fill(Color.blue)
                        .frame(width: height-5, height: height-5)
                        .position(x: min(max(xOffset + height/2, height/2), geometry.size.width - 22.5), y: geometry.size.height / 2)
                        .gesture(DragGesture()
                                    .onChanged { value in
                                        print(value)
                                        xOffset = value.location.x - 30
                                    }
                                    .onEnded { value in
                                        let threshold: CGFloat = geometry.size.width - 30
                                        if xOffset > threshold {
                                            xOffset = threshold
                                            unlocked = true
                                        } else {
                                            xOffset = 0
                                            unlocked = false
                                        }
                                    }
                        )
                }
            }
            
            Spacer()
        }
        .background(Color.black)
        .cornerRadius(height/2.0)
        .frame(height: height)
        .padding(16)
        .animation(.spring())
        //.padding()
    }
}

struct ContentView: View {
    var body: some View {
        SlideToUnlockButton()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
