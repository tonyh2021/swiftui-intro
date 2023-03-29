//
//  UIViewControllerRepresentableDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

struct UIViewControllerRepresentableDemo: View {
    
    @State private var showScreen: Bool = false
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack {
            Text("Hello SwiftUI!")
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            
            Button {
                showScreen.toggle()
            } label: {
                Text("Tap me...")
            }
            .sheet(isPresented: $showScreen) {
                UIPickerViewControllerRepresentable(image: $image, showScreen: $showScreen)
//                BasicUIViewControllerRepresentable(labelText: "New Value")
            }
        }
    }
}

struct UIViewControllerRepresentableDemo_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerRepresentableDemo()
    }
}

struct UIPickerViewControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Binding var showScreen: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    // SwiftUI -> UIKit
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    // UIKit -> SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, showScreen: $showScreen)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var image: UIImage?
        @Binding private var showScreen: Bool
        
        init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else {
                return
            }
            self.image = image
            self.showScreen = false
        }
    }
}

struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    
    let labelText: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MyFirstViewController()
        vc.labelText = labelText
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class MyFirstViewController: UIViewController {
    
    var labelText: String = "Starting Value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        let label = UILabel()
        label.text = labelText
        label.textColor = UIColor.white
        
        view.addSubview(label)
        label.frame = view.frame
    }
}
