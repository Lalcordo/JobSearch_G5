//
//  ProfileView.swift
//  JobSearch_G5
//
//  Created by Leo Cesar Alcordo on 2024-03-10.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    
    //Camera Variables
    @State private var profileImage : UIImage?
    @State private var showSheet: Bool = false
    @State private var permissionGranted: Bool = false
    @State private var showPicker : Bool = false
    @State private var isUsingCamera : Bool = false
    
    var body: some View {
        Text("Welcome, \(fireAuthHelper.user?.email ?? "User")")
        Text("Welcome, \(fireAuthHelper.user?.displayName ?? "")")
        
        VStack{
            Image(uiImage: profileImage ?? UIImage(systemName: "person.fill")!)
                .resizable()
                .frame(width: 150, height: 150, alignment: .leading)
            
            Button(action:{
                
                if self.permissionGranted {
                    self.showSheet = true
                } else {
                    self.requestPermission()
                    //alternatively, show the message for user that permissions aren't granted
                }
                
            }){
                Text("Upload Picture")
                    .padding()
            }
            .actionSheet(isPresented: self.$showSheet){
                ActionSheet(title: Text("Select Photo"),
                            message: Text("Choose profile picture to upload"),
                            buttons: [
                .default(Text("Choose photo from library")){
                    //show library picture picker
                    
                    //check if the source is available
                    guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                        print(#function, "The PhotoLibrary isn't available")
                        return
                    }
                    
                    
                    self.isUsingCamera = false
                    self.showPicker = true
                    
                },
                .default(Text("Take a new pic from Camera")){
                    //open camera
                    CameraPicker(selectedImage: self.$profileImage)
                    
                    //check if the source is available
                    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                        print(#function, "Camera isn't available")
                        return
                    }
                    
                    self.isUsingCamera = true
                    self.showPicker = true
                },
              .cancel()
             ])
            }
        }//VStack
        .fullScreenCover(isPresented: self.$showPicker){
            if (isUsingCamera){
                //open camera Picker
            }else{
                //open library picker
                LibraryPicker(selectedImage: self.$profileImage)
            }
        }
        .onAppear{
            self.checkPermission()
        }
    }
    
    private func checkPermission(){
        
        //lets you check the permission
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            self.permissionGranted = true
        case .notDetermined, .denied:
            self.permissionGranted = false
            self.requestPermission()
        case  .limited, .restricted:
            break
            //inform the user about possibly granting full access
        @unknown default:
            return
        }
    }
    
    private func requestPermission(){
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                self.permissionGranted = true
            case .notDetermined, .denied:
                self.permissionGranted = false
            case  .limited, .restricted:
                break
                //inform the user about possibly granting full access
            @unknown default:
                return
            }
        }
    }
}

#Preview {
    ProfileView()
}
