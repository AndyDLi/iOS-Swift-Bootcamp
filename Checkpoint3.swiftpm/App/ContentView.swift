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
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 250/255, green: 250/255, blue: 252/255),
                    Color(red: 245/255, green: 245/255, blue: 248/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
            
            VStack {
                NavigationBar
                Spacer()
                WorkoutLogList
            }
        }
        
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
        HStack(spacing: 16) {
            Circle()
                .fill(Color(red: 236/255, green: 106/255, blue: 112/255))
                .frame(width: 40, height: 40)
                .overlay(
                    Text("AL").font(.system(size: 14, weight: .bold)).foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Welcome Back,")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(.gray)
                Text("Andy Li")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.black)
            }
            
            Spacer()
            
            HStack {
                Button(
                    action: {
                        print("Clicked Edit!")
                    })
                {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 44, height: 44)
                            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                        
                        Image(systemName: "pencil")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 236/255, green: 106/255, blue: 112/255))
                    }
                }
    
                
                Button(
                    action: {
                        switch selectedWorkout {
                        case .lifts:
                            showAddLiftPage = true
                        case .cardio:
                            showAddCardioPage = true
                        }
                    })
                {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 44, height: 44)
                            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 236/255, green: 106/255, blue: 112/255))
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 16, leading: 24, bottom: 20, trailing: 24))
    }
    
    private var WorkoutLogList: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Activity")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("October 2025")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
            
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
    
}
