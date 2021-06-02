//
//  DevicesView.swift
//  FinalMobileProjectSwift
//
//  Created by Jesús Antonio Pérez Reyes on 01/06/21.
//
//

import SwiftUI

struct DevicesView: View {
    @ObservedObject var userController: UserController
    var body: some View {
        VStack{
            Text(userController.currentUser?.email ?? "none@none.com")
            List {
                Text("Device")
            }
        }
        .padding(.horizontal, 10)
        .navigationBarBackButtonHidden(true)
    }
}

struct DevicesView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesView(userController: UserController())
    }
}
