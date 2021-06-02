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
        Text(userController.currentUser?.email ?? "none@none.com")
    }
}

struct DevicesView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesView(userController: UserController())
    }
}
