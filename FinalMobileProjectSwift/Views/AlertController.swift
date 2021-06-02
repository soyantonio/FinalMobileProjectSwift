//
// Created by Jesús Antonio Pérez Reyes on 01/06/21.
//

import SwiftUI

class AlertController: ObservableObject {
    @Published var showDevicesView = false
    @Published var showAlert = false
    @Published var alertReason = ""
}