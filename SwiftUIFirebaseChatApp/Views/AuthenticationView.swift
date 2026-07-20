//
//  AuthenticationView.swift
//  SwiftUIFirebaseChatApp
//
//  Created by MiteshKumar Patel on 19/07/26.
//

import SwiftUI
import Firebase


class FirebaseManager: NSObject {
    
    static let shared = FirebaseManager()
     
    let auth: Auth
    
    override init() {
        
        FirebaseApp.configure()
        
        auth = Auth.auth()
        
        super.init()
    }
    
}

//When show title bar like navigation title use navigationStack
//When we need in top we can use scrollview or spacer
struct AuthenticationView: View {
    
    @State var loginMessage = ""
    
    @State var isLogin = false
    @State var email: String = ""
    @State var password: String = ""
    @State var shouldShowImage = false
    
    @State var image: UIImage?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack(spacing: 16) {
                    Picker("Select authentication", selection: $isLogin) {
                        Text("Login")
                            .tag(true)
                        
                        Text("Create Account")
                            .tag(false)
                    }
                    .pickerStyle(.segmented)
                    
                    //MARK: - If loginMode
                    if !isLogin {
                        Button(action: {
                            shouldShowImage.toggle()
                        }, label: {
                            
                            //Put inside Vstack and do background on vstack
                            VStack {
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(64)
                                }
                                else {
                                    Image(systemName: "person.fill").font(.system(size: 64))
                                        .padding()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(Color(.label))
                                }
                            }
                               .background(
                                    //Roundedrect with stroke and width
                                    Circle().stroke(Color.black,lineWidth: 2)
                                )
                        })
                       
                    }
                    
                    //MARK: - We apply color and padding is same to both text filed so use group
                    Group {
                        
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(.white)
                    
                    Button(action: {
                        handleAction()
                    }, label: {
                        Text(isLogin ? "Log In" : "Create Account")
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                        //.cornerRadius(12)
                        // .padding(.horizontal)
                    })
                }
                .padding()
                
                Text(self.loginMessage).foregroundStyle(.red)
                
            }
            .navigationTitle(isLogin ? "Log In" : "Create Account")
            .background(Color(uiColor: .init(white: 0, alpha: 0.05))) //If color expmad to background then we use here ignore safe area inside color
            
        }
        .navigationViewStyle(.stack)
        .fullScreenCover(isPresented: $shouldShowImage, content: {
            ImagePicker(image: $image,sourceType: .savedPhotosAlbum)
                    })
    }
    private func handleAction() {
        if isLogin {
            loginUser()
            email = ""
            password = ""
        }
        else {
            createNewAccount()
            email = ""
            password = ""
        }
    }
    
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            
            if let err = error {
                print("Failed to create user", err)
                self.loginMessage = "Failed to create user \(err)"
                return
            }
            
            print("Succesfully created user", result?.user.uid ?? "")
            
            self.loginMessage = "Succesfully created user \(result?.user.uid ?? "")"
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            
            if let err = error {
                print("Failed to Login user", err)
                self.loginMessage = "Failed to Login user \(err)"
                return
            }
            
            print("Succesfully Logged in user", result?.user.uid ?? "")
            
            self.loginMessage = "Succesfully Logged in user \(result?.user.uid ?? "")"
        }
    }
}

#Preview {
    AuthenticationView()
}
