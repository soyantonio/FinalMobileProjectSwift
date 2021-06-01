//
//  ContentView.swift
//  FinalMobileProjectSwift
//
//  Created by Jesús Antonio Pérez Reyes on 01/06/21.
//
//


import SwiftUI

struct ContentView: View {
    @ObservedObject var userController = UserController()

    var body: some View {
        NavigationView {
            List {

            }
            .navigationBarTitle("Users", displayMode: .inline)
            .navigationBarItems(
                    trailing: NavigationLink(destination: SignupView(userController: userController)){
                        Image(systemName: "plus").foregroundColor(.blue)
                    }
            )
        }
    }
}

struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingAlert = false
    @ObservedObject var userController: UserController
    @State var email: String = ""
    @State var password: String = ""


    var body: some View {
        VStack{
            Text("Create a new account")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
            HStack {
                Image(systemName: "person.3")
                        .foregroundColor(.gray)
                TextField("Email", text: $email)
            }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1.0))
            HStack {
                Image(systemName: "pencil.circle")
                        .foregroundColor(.gray)
                SecureField("Password", text: $password)
            }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1.0))

            HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                        .padding(.all)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(7.0)

                Button(action: {
                    guard userController.signup(user: UserModel(email: email, password: password)) else {
                        showingAlert = true
                        return
                    }
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Create account")
                }.padding(.all).foregroundColor(.white).background(Color.blue).cornerRadius(7.0)
            }.padding(.top)
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                    title: Text("Error"),
                    message: Text("Could not register user \(email)"),
                    dismissButton: .default(Text("Got it!"))
            )
        }
        .padding(.horizontal, 10)
        .navigationBarTitle("Create an Account")
        .navigationBarBackButtonHidden(true)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
