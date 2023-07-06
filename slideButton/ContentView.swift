import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var isDownloading = false
    @State private var slideEnd = false
    
    private let downloadURL = URL(string: "https://live.staticflickr.com/7151/6760135001_14c59a1490_o.jpg")!
    
    var body: some View {
        VStack {
            ImageContainer(image: image)
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(15)
                .padding(15)
                .overlay(
                    ActivityIndicator(isAnimating: $isDownloading)
                )
            
            SlideButtonView(slideEnded: $slideEnd, slideAction: {
                downloadButtonTapped(remove: !slideEnd)
            }, thumbImage: Image(systemName: slideEnd ? "checkmark.circle.fill" : "arrow.down.circle.fill"))
            
            Spacer()
        }
        .onAppear {
            // Set placeholder image
            let placeholderImage = Image("placeholder")
            image = placeholderImage
        }
    }
    
    private func downloadButtonTapped(remove: Bool) {
        if remove {
            image = Image("placeholder")
            isDownloading = false
        } else {
            isDownloading = true
            
            URLSession.shared.dataTask(with: downloadURL) { data, _, error in
                if let error = error {
                    print("Error downloading image: \(error)")
                    return
                }
                
                if let data = data, let uiImage = UIImage(data: data) {
                    let downloadedImage = Image(uiImage: uiImage)
                    
                    DispatchQueue.main.async {
                        image = downloadedImage
                        isDownloading = false
                    }
                }
            }.resume()
        }
    }
}

struct ImageContainer: View {
    var image: Image?
    
    var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}



struct ActivityIndicator: View {
    @Binding var isAnimating: Bool
    
    var body: some View {
        VStack {
            if isAnimating {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
