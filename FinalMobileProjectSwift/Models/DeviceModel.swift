//
// Created by Jesús Antonio Pérez Reyes on 01/06/21.
//

import Foundation

struct DeviceModel: Codable {
    var _id: String
    var _createdBy: String
    var name: String
    var bluetoothAddress: String
    var variant: String
}

//"_id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//"": "CLyna5Uk45DkIA333oWkBrin7FU2",
//"": "superDevice",
//"": "30:EC:5A:B0:02:00",
//"": "console"