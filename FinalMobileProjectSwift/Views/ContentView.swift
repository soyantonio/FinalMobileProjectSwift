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
    @ObservedObject var alertController = AlertController()
    @State private var selection: String? = nil

    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: DevicesView(userController: userController), isActive: $alertController.showDevicesView) {
                    Text("Show Detail")
                }.hidden()
                Text("Access to your account")
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

                Button(action: {
                    userController.login(user: UserModel(email: email, password: password), alertController: alertController)
                }) {
                    Text("Access")
                }.padding(.all).foregroundColor(.white).background(Color.blue).cornerRadius(7.0)

                NavigationLink(destination: SignupView(userController: userController)){
                    Text("Not account yet? signup")
                }.foregroundColor(Color.blue)
                .padding(.all)
                .padding(.horizontal)
            }
            .alert(isPresented: $alertController.showAlert) {
                Alert(
                        title: Text("Error"),
                        message: Text("Could not login \(email). \(alertController.alertReason)"),
                        dismissButton: .default(Text("ok"))
                )
            }
            .padding(.horizontal, 10)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Login", displayMode: .inline)
            .navigationBarItems(
                    trailing: NavigationLink(destination: SignupView(userController: userController)){
                        Image(systemName: "plus").foregroundColor(.blue)
                    }
            )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
