//
// Created by Jesús Antonio Pérez Reyes on 01/06/21.
//

import SwiftUI

class UserController: ObservableObject {
    @Published var showDevicesViewLogin = false
    @Published var showDevicesViewSignup = false
    @Published var showAlertLogin = false
    @Published var showAlertSignup = false
    @Published var alertReasonLogin = ""
    @Published var alertReasonSignup = ""
    @Published var token: String = ""
    @Published var currentUser: UserModel?

    func signup(user: UserModel) {
        showAlertSignup = false
        showDevicesViewSignup = false

        let url = URL(string: "https://us-central1-devices-mobile-project.cloudfunctions.net/api/v0/users/signup")!
        var request = URLRequest(url: url)

        guard let encoded = try? JSONEncoder().encode(user) else {
            showAlertSignup = true
            alertReasonSignup = "Could not encode user"
            return
        }
        print(String(bytes: encoded, encoding: .utf8) ?? "Non UTF-8")

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.alertReasonSignup = "HTTP error"
                    self.showAlertSignup = true
                }
                return
            }

            guard let safeData = data else {
                DispatchQueue.main.async {
                    self.alertReasonSignup = "No data"
                    self.showAlertSignup = true
                }
                return
            }

            let decoder = JSONDecoder()
            let unsafeTokenModel = try? decoder.decode(TokenModel.self, from: safeData)
            guard let tokenModel = unsafeTokenModel else {
                DispatchQueue.main.async {
                    self.alertReasonSignup = String(bytes: safeData, encoding: .utf8) ?? "Response not successful"
                    self.showAlertSignup = true
                }
                return
            }

            DispatchQueue.main.async {
                self.showDevicesViewSignup = true
                self.currentUser = user
                self.token = tokenModel.token
            }
        }.resume()
    }

    func login(user: UserModel) {
        showAlertLogin = false
        showDevicesViewLogin = false

        let url = URL(string: "https://us-central1-devices-mobile-project.cloudfunctions.net/api/v0/users/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        guard let encoded = try? JSONEncoder().encode(user) else {
            showAlertLogin = true
            alertReasonLogin = "Could not encode user"
            return
        }
        print(String(bytes: encoded, encoding: .utf8) ?? "Non UTF-8")
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.alertReasonLogin = "HTTP error"
                    self.showAlertLogin = true
                }
                return
            }

            guard let safeData = data else {
                DispatchQueue.main.async {
                    self.alertReasonLogin = "No data"
                    self.showAlertLogin = true
                }
                return
            }

            let decoder = JSONDecoder()
            let unsafeTokenModel = try? decoder.decode(TokenModel.self, from: safeData)
            guard let tokenModel = unsafeTokenModel else {
                DispatchQueue.main.async {
                    self.alertReasonLogin = String(bytes: safeData, encoding: .utf8) ?? "Response not successful"
                    self.showAlertLogin = true
                }
                return
            }

            DispatchQueue.main.async {
                self.showDevicesViewLogin = true
                self.currentUser = user
                self.token = tokenModel.token
            }
        }.resume()
    }
}

// A01313@itesm.mx
// user@example.com
