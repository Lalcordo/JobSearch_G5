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
    
    //TextField Variables
    @State private var firstNameFromUI: String = ""
    @State private var lastNameFromUI: String = ""
    
    //Show Alert variables
    @State private var showAlert: Bool = false
    @State private var alertTitle = ""
    @State private var resultMessage: String = ""
    @State private var alertConfirmation: String = ""
    
    
    var body: some View {
        Form {
            VStack{
                TextField("First Name", text: $firstNameFromUI)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                    .padding()
                    .autocorrectionDisabled()
                
                TextField("Last Name", text: $lastNameFromUI)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                    .padding()
                    .autocorrectionDisabled()
                
                Spacer()
                Button {
                    if firstNameFromUI.isEmpty || lastNameFromUI.isEmpty{
                        
                        showAlert = true
                        alertTitle = "CAUTION!"
                        resultMessage = "Fields cannot be Empty"
                        alertConfirmation = "TRY AGAIN"
                        
                        return
                    } else {
                        fireAuthHelper.updateProfile(firstName: firstNameFromUI, lastName: lastNameFromUI)
                        showAlert = true
                        alertTitle = "SUCCESS"
                        resultMessage = "Your name has been updated!"
                        alertConfirmation = "CONFIRM"
                    }
                } label: {
                    Text("Update")
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                .alert(isPresented: $showAlert){
                    Alert(title: Text("\(alertTitle)"),
                          message: Text("\(resultMessage)"),
                          dismissButton: .default(Text("\(alertConfirmation)")){})
                }
            }
        }
        
        
        
        Spacer()
        
        HStack {
            VStack{
                
                
                
                Button {
                    if self.permissionGranted {
                        self.showSheet = true
                    } else {
                        self.requestPermission()
                        //alternatively, show the message for user that permissions aren't granted
                    }
                } label: {
                    Image(uiImage: profileImage ?? UIImage(systemName: "person.fill")!)
                        .resizable()
                        .frame(width: 150, height: 150, alignment: .leading)
                    
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
            VStack{
                Text("\(fireAuthHelper.user?.displayName ?? "")")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("Email: \(fireAuthHelper.user?.email ?? "User")")
                    .font(.subheadline)
                    .italic()
                
                
            }
        }
        .onAppear{
            self.checkPermission()
        }
        
        Spacer()
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
