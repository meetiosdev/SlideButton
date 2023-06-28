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
                
                Circle()
                    .fill(Color.green)
                    .frame(width: 60, height: 60)
                    .offset(x: xOffset)
                    .gesture(DragGesture()
                                .onChanged { value in
                                    let newOffset = xOffset + value.translation.width
                                    xOffset = max(0, min(newOffset, 200))
                                }
                                .onEnded { value in
                                    if xOffset > 200 {
                                        unlocked = true
                                    } else {
                                        xOffset = 0
                                        unlocked = false
                                    }
                                }
                    )
            }
            
            Spacer()
        }
        .background(Color.black)
        .cornerRadius(10)
        .frame(height: 80)
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
