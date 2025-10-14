import SwiftUI

struct LiftLogView: View {
    let lift: Lift
    
    var body: some View {
        HStack {
            dateBox(dayOfWeek: lift.dayOfWeek, dayOfMonth: lift.dayOfMonth)
            workoutDetails
        }
    }
    
    // Workout Log List Components //
    
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
        VStack (alignment: .leading, spacing: 4) {
            HStack {
                Text(lift.title)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Text("\(lift.duration) Min")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Text("\(Image(systemName: "figure.strengthtraining.traditional")) \(lift.musclesHit) Muscles Hit")
            Text("\(Image(systemName: "trophy.fill")) \(lift.personalRecords) PRs")
        }.padding(Edge.Set.horizontal, 10)
    }
}
