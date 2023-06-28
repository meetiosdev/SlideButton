import SwiftUI

struct SlideToUnlockButton: View {
    @State private var xOffset: CGFloat = 0
    @State private var unlocked = false
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                if xOffset >= 200 {
                    Text("Unlocked")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .transition(.opacity)
                } else {
                    Text("Slide to Unlock")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .transition(.opacity)
                }
                
                GeometryReader { geometry in
                    Circle()
                        .fill(Color.green)
                        .frame(width: 60, height: 60)
                        .position(x: min(max(xOffset + 30, 30), geometry.size.width - 30), y: geometry.size.height / 2)
                        .gesture(DragGesture()
                                    .onChanged { value in
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
        .cornerRadius(30)
        .frame(height: 60)
        .animation(.spring())
        .padding()
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
