//
//  ImagePick.swift
//  MC3
//
//  Created by Peter Andrew on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//
// tutorial can be found at Example/ImagePickerEmbedExample

import SwiftUI
import AVFoundation

struct ImagePickerEmbed<Content: View>:View {
    @Binding var image : Image?
    let content:Content
    
    @State private var showImagePicker : Bool = false
    @State private var notAllowAcces:Bool = false
    @State private var showingActionSheet: Bool = false
    @State private var sourceType:UIImagePickerController.SourceType = .photoLibrary
    
    init(imageBinding:Binding<Image?>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._image = imageBinding
    }
    
    var body: some View {
        VStack {
            Button( action: {
                self.showingActionSheet = true
            }){
                self.content
                .buttonStyle(PlainButtonStyle())
            }
        }.actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Select Picture"), message: Text("Select Image Source"), buttons: [
                .default(Text("Photo Library")) {
                    self.sourceType = .photoLibrary
                    self.showImagePicker = true
                },
                .default(Text("Camera")) {
                    self.AskPermission(cb: {
                        self.sourceType = .camera
                        self.showImagePicker = true
                    })
                },
                .cancel()
            ])
        }.alert(isPresented: $notAllowAcces) {
            Alert(title: Text("Camera access"), message: Text("We cannot access your camera, please grant access through settings"), dismissButton: .default(Text("ok")))
        }.sheet(isPresented: self.$showImagePicker){
            ImagePicker(isShown: self.$showImagePicker, image: self.$image, sourceType: self.sourceType)
        }
    }
    
    func AskPermission(cb: @escaping(()->Void))->Void {
        switch AVCaptureDevice.authorizationStatus(for: .video){
            case .authorized:
                 cb()

            case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    cb()
                }
            }
            case .denied:
                self.notAllowAcces = true
            break
            case .restricted: break
            @unknown default: break // let something happend if not the case
        }
    }
}

struct ImagePick_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerEmbed(imageBinding: .constant(nil)){
            Text("pick Photo")
        }
    }
}

struct ImagePicker : UIViewControllerRepresentable {
    @Binding var isShown    : Bool
    @Binding var image      : Image?
    var sourceType : UIImagePickerController.SourceType
        
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> ImagePickerCordinator {
        return ImagePickerCordinator(isShown: $isShown, image: $image)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
}

class ImagePickerCordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @Binding var isShown    : Bool
    @Binding var image      : Image?
    
    init(isShown : Binding<Bool>, image: Binding<Image?>) {
        _isShown = isShown
        _image   = image
    }
    
    //Selected Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        let url = info[UIImagePickerController.InfoKey.imageURL] as? URL
        image = Image(uiImage: uiImage)
        isShown = false
    }
    
    //Image selection got cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}


