import SwiftUI

struct Lift: Identifiable {
    let id = UUID()
    let dayOfWeek: String
    let dayOfMonth: Int
    let title: String
    let musclesHit: Int
    let personalRecords: Int
    let duration: Int
    let date: Date
}
