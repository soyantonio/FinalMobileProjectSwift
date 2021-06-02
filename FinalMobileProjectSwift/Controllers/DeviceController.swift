//
// Created by Jesús Antonio Pérez Reyes on 01/06/21.
//

import SwiftUI

class DeviceController: ObservableObject {
    @Published var devices = [DeviceModel]()

    func loadDevices(userController: UserController){
        guard userController.currentUser != nil else {return}
        guard userController.token != "" else {return}

        guard let url = URL(string: "https://us-central1-devices-mobile-project.cloudfunctions.net/api/v0/devices") else {
            return print("Error when creating the URL")
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let bearerToken = "Bearer \(userController.token)"
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return print(error!)
            }
            guard let safeData = data else {
                return print("No data")
            }

            // TODO handle expired token

            let decoder = JSONDecoder()
            let unsafeList = try? decoder.decode([DeviceModel].self, from: safeData)
            guard let list = unsafeList else {
                return print("Could not decode device list")
            }

            DispatchQueue.main.async {
                self.devices = list;
            }
        }.resume()
    }
}