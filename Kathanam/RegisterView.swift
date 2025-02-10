//
//  RegisterView.swift
//  Kathanam
//
//  Created by palak seth on 09/02/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showSuccessPopup = false
    @State private var confirmPassword: String = ""
    @State private var navigateToHome = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    // Curved header background
                    ZStack(alignment: .topLeading) {
                        WaveShape()
                            .fill(Color.orange)
                            .frame(height: 200)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Hello! Register to")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("get started")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 30)
                        .padding(.top, 50)
                    }
                    
                    Spacer(minLength: 20)
                    
                    // Username Field
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                        TextField("Username", text: $username)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal)
                    
                    // Email Field
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.blue)
                        TextField("example@gmail.com", text: $email)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal)
                    
                    // Password Field
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.blue)
                        SecureField("Password", text: $password)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal)
                    
                    // Confirm Password Field
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.blue)
                        SecureField("Confirm Password", text: $confirmPassword)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal)
                    
                    Spacer(minLength: 20)
                    
                    // Register Button
                    Button(action: {
                        showSuccessPopup = true
                    }) {
                        Text("Register")
                            .font(.system(size: 20, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                            .shadow(radius: 5)
                    }
                    .alert("You have successfully been registered!", isPresented: $showSuccessPopup) {
                        Button("OK", action: {
                            navigateToHome = true // Trigger navigation to HomeView
                        })
                    }
                    
                    // NavigationLink to HomeView
                    NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                        EmptyView()
                    }
                    
                    
                    
                    
                    // Social Login
                    HStack {
                        Text("or Register with")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .padding(.vertical, 20)
                    }
                    
                    HStack(spacing: 30) {
                        // Facebook Icon
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text("f")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(.white)
                            )
                        
                        // Google Icon
                        Circle()
                            .fill(Color.white)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text("G")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(.red)
                            )
                            .shadow(radius: 2)
                        
                        // Apple Icon using SF Symbol
                        Circle()
                            .fill(Color.black)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Image(systemName: "applelogo")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                            )
                    }
                    .padding(.bottom, 20)
                    
                    // Already have an account
                    HStack {
                        Text("Already have an account?")
                            .font(.system(size: 16))
                        NavigationLink(destination: LoginView()) {
                            Text("Login Now")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
    }
    
    //struct WaveShape: Shape {
    //    func path(in rect: CGRect) -> Path {
    //        var path = Path()
    //        path.move(to: CGPoint(x: 0, y: rect.height))
    //        path.addQuadCurve(
    //            to: CGPoint(x: rect.width, y: rect.height),
    //            control: CGPoint(x: rect.width / 2, y: rect.height - 100)
    //        )
    //        path.addLine(to: CGPoint(x: rect.width, y: 0))
    //        path.addLine(to: CGPoint(x: 0, y: 0))
    //        path.closeSubpath()
    //        return path
    //    }
    //}
}

#Preview {
    RegisterView()
}
