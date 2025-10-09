import SwiftUI

struct ContentView: View {
    enum WorkoutType: String, CaseIterable {
        case lifts = "Lifts"
        case cardio = "Cardio"
    }
    
    @State private var showAddLiftPage: Bool = false
    @State private var showAddCardioPage: Bool = false
    @State private var lifts: [Lift] = []
    @State private var cardio: [Cardio] = []
    @State private var selectedWorkout: WorkoutType = .lifts
    
    var body: some View {
        VStack {
            NavigationBar
            Spacer()
            WorkoutLogList
            
        }.preferredColorScheme(ColorScheme.dark)
        
        // Shows Logging Pages
        .sheet(isPresented: $showAddLiftPage) {
            AddLiftLog(onAdd: { newLift in
                lifts.append(newLift)
                lifts.sort { $0.date > $1.date }
                showAddLiftPage = false
            })
        }
        .sheet(isPresented: $showAddCardioPage) {
            AddCardioLog(onAdd: { newCardio in
                cardio.append(newCardio)
                cardio.sort { $0.date > $1.date }
                showAddCardioPage = false
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
                action: {
                    switch selectedWorkout {
                        case .lifts:
                            showAddLiftPage = true
                        case .cardio:
                            showAddCardioPage = true
                        }
                },
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
            
            Picker("Workout Type", selection: $selectedWorkout) {
                ForEach(WorkoutType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.bottom, 8)
            
            ScrollView {
                switch selectedWorkout {
                    case .lifts:
                        ForEach(lifts) { lift in
                            LiftLogView(lift: lift)
                                .padding()
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    case .cardio:
                        ForEach(cardio) { session in
                            CardioLogView(cardio: session)
                                .padding()
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                }
            }
            Spacer()
        }
    }
    
    private func tabButton(type tab: WorkoutType) -> some View {
        Button {
            selectedWorkout = tab
        } label: {
            Text(tab.rawValue)
                .font(.subheadline).bold()
                .foregroundColor(selectedWorkout == tab ? Color.black : Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(selectedWorkout == tab ? Color.white : Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white.opacity(0.4), lineWidth: 1)
                        )
                )
        }
        .buttonStyle(.plain)
    }
}
