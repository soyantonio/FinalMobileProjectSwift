//
// Created by Jesús Antonio Pérez Reyes on 01/06/21.
//

import SwiftUI

class UserController: ObservableObject {
    @Published var token: String = ""
    @Published var currentUser: UserModel?

    func signup(user: UserModel, alertController: AlertController) {
        alertController.showAlert = false
        alertController.showDevicesView = false

        let url = URL(string: "https://us-central1-devices-mobile-project.cloudfunctions.net/api/v0/users/signup")!
        var request = URLRequest(url: url)

        guard let encoded = try? JSONEncoder().encode(user) else {
            alertController.showAlert = true
            alertController.alertReason = "Could not encode user"
            return
        }
        print(String(bytes: encoded, encoding: .utf8) ?? "Non UTF-8")

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    alertController.alertReason = "HTTP error"
                    alertController.showAlert = true
                }
                return
            }

            guard let safeData = data else {
                DispatchQueue.main.async {
                    alertController.alertReason = "No data"
                    alertController.showAlert = true
                }
                return
            }

            let decoder = JSONDecoder()
            let unsafeTokenModel = try? decoder.decode(TokenModel.self, from: safeData)
            guard let tokenModel = unsafeTokenModel else {
                DispatchQueue.main.async {
                    alertController.alertReason = String(bytes: safeData, encoding: .utf8) ?? "Response not successful"
                    alertController.showAlert = true
                }
                return
            }

            DispatchQueue.main.async {
                alertController.showDevicesView = true
                self.currentUser = user
                self.token = tokenModel.token
            }
        }.resume()
    }

    func login(user: UserModel, alertController: AlertController) {
        alertController.showAlert = false
        alertController.showDevicesView = false

        let url = URL(string: "https://us-central1-devices-mobile-project.cloudfunctions.net/api/v0/users/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        guard let encoded = try? JSONEncoder().encode(user) else {
            alertController.showAlert = true
            alertController.alertReason = "Could not encode user"
            return
        }
        print(String(bytes: encoded, encoding: .utf8) ?? "Non UTF-8")
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    alertController.alertReason = "HTTP error"
                    alertController.showAlert = true
                }
                return
            }

            guard let safeData = data else {
                DispatchQueue.main.async {
                    alertController.alertReason = "No data"
                    alertController.showAlert = true
                }
                return
            }

            let decoder = JSONDecoder()
            let unsafeTokenModel = try? decoder.decode(TokenModel.self, from: safeData)
            guard let tokenModel = unsafeTokenModel else {
                DispatchQueue.main.async {
                    alertController.alertReason = String(bytes: safeData, encoding: .utf8) ?? "Response not successful"
                    alertController.showAlert = true
                }
                return
            }

            DispatchQueue.main.async {
                alertController.showDevicesView = true
                self.currentUser = user
                self.token = tokenModel.token
            }
        }.resume()
    }
}

// A01313@itesm.mx
// user@example.com
