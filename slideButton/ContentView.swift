import SwiftUI

struct SlideToUnlockButton: View {
    @State private var xOffset: CGFloat = 0
    @State private var unlocked = false
    @State private var height: CGFloat = 60
    @State private var isLoading = false
    @State private var showCheckedInImage = false
    //@State private var showText = true
    
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
    
    private var loaderOpacity: Double {
        return Double(xOffset / (thumbEnd + halfHeight))
    }
    
    private var showLoader: Bool {
        return xOffset >= 300
    }
    
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
                                .animation(.easeInOut)
                        }
                        
                        Circle()
                            .fill(Color.blue)
                            .frame(width: thumbSize, height: thumbSize)
                            .position(
                                x: min(max(xOffset + halfHeight, halfHeight),
                                       geometry.size.width - thumbEnd),
                                y: geometry.size.height / 2)
                            .overlay(
                                Group {
                                    if showLoader {
                                        LoaderView()
                                            .foregroundColor(.white)
                                            .opacity(loaderOpacity)
                                            .onAppear {
                                                isLoading = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                                    isLoading = false
                                                    showCheckedInImage = true
                                                }
                                            }
                                    } else {
                                        if showCheckedInImage {
                                            Image(systemName: "checkmark.circle.fill")
                                                .resizable()
                                                .frame(width: imageHeight, height: imageHeight)
                                                .foregroundColor(.white)
                                        } else {
                                            Image(systemName: "checkmark.circle")
                                                .resizable()
                                                .frame(width: imageHeight, height: imageHeight)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                .position(
                                    x: min(max(xOffset + halfHeight, halfHeight),
                                           geometry.size.width - thumbEnd),
                                    y: geometry.size.height / 2
                                )
                            )
                            .gesture(
                                DragGesture()
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



struct LoaderView: View {
    @State private var isLoading = false
    
    var body: some View {
        HStack(spacing: 3) {
            Circle()
                .frame(width: 10, height: 10)
                .opacity(isLoading ? 1 : 0)
                .animation(Animation.easeInOut(duration: 0.8).repeatForever())
            
            Circle()
                .frame(width: 10, height: 10)
                .opacity(isLoading ? 1 : 0)
                .animation(Animation.easeInOut(duration: 0.8).delay(0.3).repeatForever())
            
            Circle()
                .frame(width: 10, height: 10)
                .opacity(isLoading ? 1 : 0)
                .animation(Animation.easeInOut(duration: 0.8).delay(0.6).repeatForever())
        }
        .onAppear {
            isLoading = true
        }
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
