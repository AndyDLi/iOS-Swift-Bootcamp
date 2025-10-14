import SwiftUI

struct CardioLogView: View {
    let cardio: Cardio
    
    var body: some View {
        HStack {
            dateBox(dayOfWeek: cardio.dayOfWeek, dayOfMonth: cardio.dayOfMonth)
            workoutDetails
        }
    }
    
    private func dateBox(dayOfWeek: String, dayOfMonth: Int) -> some View {
        VStack {
            Text(dayOfWeek)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            Text("\(dayOfMonth)")
                .font(.title2)
                .fontWeight(.bold)
        }
        .frame(width: 60, height: 60)
        .border(.black)
        .cornerRadius(15)
    }
    
    private var workoutDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(cardio.title)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Text("\(cardio.duration) Min")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Text("\(Image(systemName: "flame.fill")) \(cardio.calories) Cal")
            Text("\(Image(systemName: "heart.fill")) Max HR \(cardio.maxHeartRate)")
        }
        .padding(Edge.Set.horizontal, 10)
    }
}

