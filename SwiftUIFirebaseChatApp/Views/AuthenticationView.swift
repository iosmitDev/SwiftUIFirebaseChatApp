//
//  AuthenticationView.swift
//  SwiftUIFirebaseChatApp
//
//  Created by MiteshKumar Patel on 19/07/26.
//

import SwiftUI
//When show title bar like navigation title use navigationStack
//When we need in top we can use scrollview or spacer
struct AuthenticationView: View {
    
    @State var isLogin = false
    @State var email: String = ""
    @State var password: String = ""
    
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
                            
                        }, label: {
                            Image(systemName: "person.fill").font(.system(size: 64))
                                .padding()
                                .frame(width: 100, height: 100)
                                .background(
                                    Circle().stroke(Color.black,lineWidth: 2)
                                )
                        })
                        .foregroundColor(.black)
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
                
            }
            .navigationTitle(isLogin ? "Log In" : "Create Account")
            .background(Color(uiColor: .init(white: 0, alpha: 0.05))) //If color expmad to background then we use here ignore safe area inside color
           
        }
        
    }
    private func handleAction() {
        if isLogin {
            print("Login")
        }
        else {
            print("Register")
        }
    }
}

#Preview {
    AuthenticationView()
}
