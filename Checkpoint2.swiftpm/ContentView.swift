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
    @State private var showAddWorkoutPage: Bool = false
    @State private var workouts: [Workout] = []
    
    var body: some View {
        VStack {
            NavigationBar
            Spacer()
            WorkoutLogList
            
        }.preferredColorScheme(ColorScheme.dark)
        
        // Shows Logging Page if True
        .sheet(isPresented: $showAddWorkoutPage) {
            // takes a closure onAdd, passing up the created newWorkout
            AddWorkoutLog(onAdd: { newWorkout in
                workouts.append(newWorkout)
                showAddWorkoutPage = false
            })
        }
    }
    
    // Front Page Components //
    
    private var NavigationBar: some View {
        HStack {
            Button(
                action: { print("Clicked Edit!")},
                label: { Text("Edit") }
            )
            Spacer()
            Text("Andy Li")
                .font(.title2)
                .bold()
                .foregroundColor(.red)
            Spacer()
            Button(
                action: { showAddWorkoutPage = true },
                label: { Label("", systemImage: "plus") }
            )
        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10))
    }
    
    private var WorkoutLogList: some View {
        VStack {
            Text("October 2025 Log")
                .font(Font.largeTitle)
                .bold()
                .padding(.vertical)
            ScrollView { // allows scrolling behavior
                ForEach(workouts) {
                    workout in
                    WorkoutLog(workout: workout)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            Spacer()
        }
    }
}

struct WorkoutLog: View {
    let workout: Workout
    
    var body: some View {
        HStack {
            dateBox
            workoutDetails
        }
    }
    
    // Workout Log List Components //
    
    private var dateBox: some View {
        VStack {
            Text(workout.dayOfWeek)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            Text("\(workout.dayOfMonth)") // Text Expects a String
                .font(.title2)
                .fontWeight(.bold)
        }.frame(width: 60, height: 60).border(.white).cornerRadius(15)
    }
    
    private var workoutDetails: some View {
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
        }.padding(Edge.Set.horizontal, 10)
    }
}

struct AddWorkoutLog: View {
    @Environment(\.dismiss) var dismiss // closes view
    var onAdd: (Workout) -> (Void)
    
    @State private var dayOfWeek: String = ""
    @State private var dayOfMonth: String = ""
    @State private var title: String = ""
    @State private var musclesHit: String = ""
    @State private var personalRecords: String = ""
    @State private var duration: String = ""
    
    @State private var alertMessage: String = "";
    @State private var showAlert: Bool = false;
    
    var body: some View {
        VStack {
            HStack {
                Button(
                    action: { dismiss() },
                    label: { Label("", systemImage: "chevron.left") }
                )
                Spacer()
            }.padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 10))
            
            Text("New Workout Log").font(.largeTitle).bold()
            
            inputForm
            
            Button(
                action: {
                    addLog();
                    if (!showAlert) {
                        dismiss()
                    }
                },
                label: { Text("Add to Log") }
            )
        }
        Spacer()
        
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid"), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    // Add Log Components //
    
    private var inputForm: some View {
        VStack {
            TextField("Day of Week:", text: $dayOfWeek).padding(.horizontal)
            Divider().overlay(.white)
            TextField("Day of Month:", text: $dayOfMonth).padding(.horizontal)
            Divider().overlay(.white)
            TextField("Title:", text: $title).padding(.horizontal)
            Divider().overlay(.white)
            TextField("Muscles Hit:", text: $musclesHit).padding(.horizontal)
            Divider().overlay(.white)
            TextField("PRs", text: $personalRecords).padding(.horizontal)
            Divider().overlay(.white)
            TextField("Duration:", text: $duration).padding(.horizontal)
            Divider().overlay(.white)
        }.padding()
        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.black)).padding()
    }
    
    private func addLog() -> (Void) {
        guard !dayOfWeek.isEmpty || !dayOfMonth.isEmpty || !title.isEmpty || !musclesHit.isEmpty || !personalRecords.isEmpty || !duration.isEmpty else {
            alertMessage = "All Fields Are Required"
            showAlert = true
            return
        }
        
        guard let dayOfMonthInt = Int(dayOfMonth), (1...31).contains(dayOfMonthInt) else {
            alertMessage = "Enter a Valid Day of Month"
            showAlert = true
            return
        }
        
        guard let musclesHitInt = Int(musclesHit), musclesHitInt >= 0 else {
            alertMessage = "Enter a Valid Number of Muscles Hit"
            showAlert = true
            return
        }
        
        guard let personalRecordsInt = Int(personalRecords), personalRecordsInt >= 0 else {
            alertMessage = "Enter a Valid Number of Personal Records"
            showAlert = true
            return
        }
        
        guard let durationInt = Int(duration), durationInt >= 0 else {
            alertMessage = "Enter a Valid Duration"
            showAlert = true
            return
        }
        
        let newWorkout = Workout(
            dayOfWeek: dayOfWeek,
            dayOfMonth: dayOfMonthInt,
            title: title,
            musclesHit: musclesHitInt,
            personalRecords: personalRecordsInt,
            duration: durationInt
        )
        
        onAdd(newWorkout)
        showAlert = false
    }
}
