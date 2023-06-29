import SwiftUI

struct SlideToUnlockButton: View {
    @Binding var unlocked: Bool
    var unlockAction: () -> Void
    var thumbImage: Image
    
    @State private var xOffset: CGFloat = 0
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
    
    private var imageHeight: CGFloat {
        return (height - (thumbPadding * 2)) / 2
    }
    
    private var thumbEnd: CGFloat {
        return ((height - (2 * thumbPadding)) / 2) - (thumbPadding / 2)
    }
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    if xOffset >= geometry.size.width * 0.75 {
                        Text("Slide to check out")
                            .font(Font.custom("Assistant", size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    } else {
                        Text("Slide to check in")
                            .font(Font.custom("Assistant", size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                    
                    Circle()
                        .fill(Color.blue)
                        .frame(width: thumbSize, height: thumbSize)
                        .position(
                            x: min(max(xOffset + halfHeight, halfHeight), geometry.size.width - thumbEnd),
                            y: geometry.size.height / 2)
                        .overlay(
                            thumbImage
                                .resizable()
                                .frame(width: imageHeight, height: imageHeight)
                                .foregroundColor(.white)
                                .position(
                                    x: min(max(xOffset + halfHeight, halfHeight), geometry.size.width - thumbEnd),
                                    y: geometry.size.height / 2)
                        )
                        .gesture(DragGesture()
                                    .onChanged { value in
                                        xOffset = value.location.x - halfHeight
                                        let threshold: CGFloat = geometry.size.width * 0.75
                                        unlocked = xOffset >= threshold
                                        unlockAction()
                                    }
                                    .onEnded { value in
                                        let threshold: CGFloat = geometry.size.width * 0.75
                                        if xOffset > threshold {
                                            xOffset = geometry.size.width - (height - (thumbPadding * 2))
                                            unlocked = true
                                            
                                        } else {
                                            xOffset = 0
                                            unlocked = false
                                        }
                                        unlockAction()
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
    @State private var unlocked = false
    
    var body: some View {
        SlideToUnlockButton(unlocked: $unlocked, unlockAction: {
            if unlocked{
                print("open")
            }else{
                print("locked")
            }
        }, thumbImage: Image(unlocked ? "checkedIn" : "checkInIcon"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
