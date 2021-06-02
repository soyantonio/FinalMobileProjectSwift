//
// Created by Jesús Antonio Pérez Reyes on 01/06/21.
//

import SwiftUI

class UserController: ObservableObject {
    @Published var showDevicesView = false
    @Published var showAlert = false
    @Published var alertReason = ""
    @Published var token: String = ""
    @Published var currentUser: UserModel?

    func signup(user: UserModel) {
        showAlert = false
        showDevicesView = false

        let url = URL(string: "https://us-central1-devices-mobile-project.cloudfunctions.net/api/v0/users/signup")!
        var request = URLRequest(url: url)

        guard let encoded = try? JSONEncoder().encode(user) else {
            showAlert = true
            alertReason = "Could not encode user"
            return
        }
        print(String(bytes: encoded, encoding: .utf8))

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.alertReason = "HTTP error"
                    self.showAlert = true
                }
                return
            }

            guard let safeData = data else {
                DispatchQueue.main.async {
                    self.alertReason = "No data"
                    self.showAlert = true
                }
                return
            }

            let decoder = JSONDecoder()
            let unsafeTokenModel = try? decoder.decode(TokenModel.self, from: safeData)
            guard let tokenModel = unsafeTokenModel else {
                DispatchQueue.main.async {
                    self.alertReason = String(bytes: safeData, encoding: .utf8) ?? "Response not successful"
                    self.showAlert = true
                }
                return
            }

            DispatchQueue.main.async {
                self.showDevicesView = true
                self.currentUser = user
                self.token = tokenModel.token
            }
        }.resume()
    }
}

// A01313@itesm.mx