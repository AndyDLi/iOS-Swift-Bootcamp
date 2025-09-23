import SwiftUI

struct Workout: Identifiable {
    let id = UUID()
    let dayOfWeek: String
    let dayOfMonth: Int
    let title: String
    let musclesHit: Int
    let personalRecords: Int
    let duration: Int
}

struct ContentView: View {
    let workouts: [Workout] = [
        Workout(
            dayOfWeek: "Mon",
            dayOfMonth: 15,
            title: "Push",
            musclesHit: 3,
            personalRecords: 1,
            duration: 75
        ),
        Workout(
            dayOfWeek: "Tues",
            dayOfMonth: 16,
            title: "Push",
            musclesHit: 3,
            personalRecords: 2,
            duration: 75
        ),
        Workout(
            dayOfWeek: "Wed",
            dayOfMonth: 17,
            title: "Legs",
            musclesHit: 3,
            personalRecords: 3,
            duration: 75
        ),
        Workout(
            dayOfWeek: "Fri",
            dayOfMonth: 19,
            title: "Upper",
            musclesHit: 3,
            personalRecords: 1,
            duration: 75
        ),
        Workout(
            dayOfWeek: "Sat",
            dayOfMonth: 20,
            title: "Lower",
            musclesHit: 3,
            personalRecords: 0,
            duration: 75
        ),
    ]
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { print("Clicked Edit!")}, label: { Text("Edit") })
                Spacer();
                Text("Andy Li")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.red)
                Spacer();
                Button(action: { print("Clicked Plus!")} , label: {
                    Label("", systemImage: "plus") }
                )
            }.padding(EdgeInsets(top: 10, leading: 22, bottom: 10, trailing: 10))
            Spacer();
            
            VStack {
                Text("September 2025 Log")
                    .font(Font.largeTitle)
                    .bold()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                ForEach(workouts) {
                    workout in
                    WorkoutLog(workout: workout)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                Spacer()
            }
        }.preferredColorScheme(ColorScheme.dark)
    }
}

struct WorkoutLog: View {
    let workout: Workout
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Text(workout.dayOfWeek)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    Text("\(workout.dayOfMonth)") // Text Expects a String
                        .font(.title2)
                        .fontWeight(.bold)
                }.frame(width: 40)
                
                VStack (alignment: .leading, spacing: 4) {
                    HStack {
                        Text(workout.title)
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(workout.duration) Min")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Text("\(Image(systemName: "figure.strengthtraining.traditional")) \(workout.musclesHit) Muscles Hit")
                    Text("\(Image(systemName: "trophy.fill")) \(workout.personalRecords) PRs")
                }
            }
        }
    }
}
