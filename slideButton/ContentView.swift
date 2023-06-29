import SwiftUI

struct SlideToUnlockButton: View {
    @State private var xOffset: CGFloat = 0
    @State private var unlocked = false
    @State private var height: CGFloat = 60
    private var thumbPadding: CGFloat {
        return height / 12
    }
    private var thumbSize: CGFloat {
        return height - thumbPadding
    }
    private var cornerRadius: CGFloat {
        return height / 2
    }
    private var halfHeight: CGFloat {
        return cornerRadius
    }
    
    private var imageheight: CGFloat {
        return (height - (thumbPadding * 2))/2
    }
    
    private var thumbEnd: CGFloat {
        return ((height - (2 * thumbPadding))/2) - (thumbPadding/2)
    }
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    if xOffset >= geometry.size.width - height{
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
                        .frame(width: thumbSize, height: thumbSize)
                        .position(
                            x: min(max(xOffset + halfHeight, halfHeight),
                                   geometry.size.width - thumbEnd),
                            y: geometry.size.height / 2)
                        .overlay(
                            
                            Image(unlocked ? "checkedIn" : "checkInIcon")
                                .resizable()
                                .frame(width: imageheight, height: imageheight)
                                .foregroundColor(.white)
                                .position(
                                    x: min(max(xOffset + halfHeight, halfHeight),
                                           geometry.size.width - thumbEnd),
                                    y: geometry.size.height / 2)
                        )
                        .gesture(DragGesture()
                                    .onChanged { value in
                                        xOffset = value.location.x - halfHeight
                                        print(xOffset)
                                    }
                                    .onEnded { value in
                                        let threshold: CGFloat = geometry.size.width - halfHeight
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
        .cornerRadius(cornerRadius)
        .frame(height: height)
        .padding(16)
        .animation(.spring())
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
