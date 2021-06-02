//
//  DevicesView.swift
//  FinalMobileProjectSwift
//
//  Created by Jesús Antonio Pérez Reyes on 01/06/21.
//
//

import SwiftUI
import URLImage

struct DevicesView: View {
    @ObservedObject var userController: UserController
    @ObservedObject var deviceController = DeviceController()

    var body: some View {
        VStack{
            Text(userController.currentUser?.email ?? "none@none.com")

            Button("Refresh") {
                deviceController.loadDevices(userController: userController)
            }
            .padding(.all)
            .padding(.horizontal)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(7.0)


            List(deviceController.devices, id: \._id) { device in
                URLImage(url: (URL(string: "https://via.placeholder.com/80X100"))!) {
                    image in image.resizable().clipped().frame(width: 80, height: 100, alignment: .center)
                }
                Text(device.name)
            }
        }
        .navigationBarTitle("Devices", displayMode: .inline)
        .onAppear(perform: {
            deviceController.loadDevices(userController: userController)
        })
        .padding(.horizontal, 10)
    }
}

struct DevicesView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesView(userController: UserController())
    }
}
