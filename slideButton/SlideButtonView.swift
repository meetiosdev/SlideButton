//
//  Button.swift
//  slideButton
//
//  Created by Swarajmeet Singh on 29/06/23.
//

import SwiftUI
struct SlideButtonView: View {
    @Binding var checked: Bool
    var checkInAction: () -> Void
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
                    
                    VStack {
                        thumbImage
                            .resizable()
                            .frame(width: imageHeight, height: imageHeight)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.red)
                    .frame(width: thumbSize, height: thumbSize)
                    .cornerRadius(thumbSize / 2)
                    .position(
                        x: min(max(xOffset + halfHeight, halfHeight), geometry.size.width - thumbEnd),
                        y: geometry.size.height / 2
                    )
                    .gesture(DragGesture()
                                .onChanged { value in
                                    xOffset = value.location.x - halfHeight
                                    let threshold: CGFloat = geometry.size.width * 0.75
                                    checked = xOffset >= threshold
                                    checkInAction()
                                }
                                .onEnded { value in
                                    let threshold: CGFloat = geometry.size.width * 0.75
                                    if xOffset > threshold {
                                        xOffset = geometry.size.width - (height - (thumbPadding * 2))
                                        checked = true
                                    } else {
                                        xOffset = 0
                                        checked = false
                                    }
                                    checkInAction()
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

