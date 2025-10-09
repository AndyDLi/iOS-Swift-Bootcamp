import SwiftUI

struct Cardio: Identifiable {
    let id = UUID()
    let dayOfWeek: String
    let dayOfMonth: Int
    let title: String
    let duration: Int
    let calories: Int
    let maxHeartRate: Int
    let date: Date
}
