//
// Created by Jesús Antonio Pérez Reyes on 01/06/21.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var userController: UserController

    @State var email: String = ""
    @State var password: String = ""


    var body: some View {
        VStack{
            NavigationLink(destination: DevicesView(userController: userController), isActive: $userController.showDevicesView) {
                Text("Show Detail").hidden()
            }
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
                    userController.signup(user: UserModel(email: email, password: password))
                }) {
                    Text("Create account")
                }.padding(.all).foregroundColor(.white).background(Color.blue).cornerRadius(7.0)
            }.padding(.top)
        }
        .alert(isPresented: $userController.showAlert) {
            Alert(
                    title: Text("Error"),
                    message: Text("Could not register user \(email). \(userController.alertReason)"),
                    dismissButton: .default(Text("Got it!"))
            )
        }
        .padding(.horizontal, 10)
        .navigationBarTitle("Create an Account")
        .navigationBarBackButtonHidden(true)
    }
}

// A01313@itesm.mx