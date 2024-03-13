//
//  CameraPicker.swift
//  JobSearch_G5
//
//  Created by Leo Cesar Alcordo on 2024-03-13.
//

import Foundation
import SwiftUI
import PhotosUI

struct CameraPicker : UIViewControllerRepresentable{
    
  @Binding var selectedImage:UIImage?
    
  func makeUIViewController(context: Context) -> UIImagePickerController {
    //configure CameraPicker
    var imagePicker=UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.delegate = context.coordinator
    return imagePicker
  }
    
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    //nothing to update on UI
  }
    
  func makeCoordinator() -> CameraPicker.Coordinator {
    return Coordinator(parent:self)
  }
    
  class Coordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
      
    var parent : CameraPicker
      
    init(parent:CameraPicker){
      self.parent=parent
    }
      
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
      //use clicked picture
      if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
        self.parent.selectedImage = image
        picker.dismiss(animated: true)
          
          //save image to PhotoLIbrary
          PHPhotoLibrary.shared().performChanges( {
              let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
              
              PHAssetCollectionChangeRequest(for:
                                                PHAssetCollection())?.addAssets([creationRequest.placeholderForCreatedAsset!] as NSArray)
          })
      }
      else{
        print(#function, "Image not available from originalImage property")
        return
      }
    }
      
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        
    }
  }
}
