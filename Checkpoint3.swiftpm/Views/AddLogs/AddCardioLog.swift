import SwiftUI

struct AddCardioLog: View {
    @Environment(\.dismiss) var dismiss
    var onAdd: (Cardio) -> (Void)
    
    @State private var selectedDate: Date = Date()
    
    @State private var title: String = ""
    @State private var duration: String = ""
    @State private var calories: String = ""
    @State private var maxHeartRate: String = ""
    
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color(red: 250/255, green: 250/255, blue: 252/255)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 36, height: 36)
                                .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
                            
                            Image(systemName: "xmark")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    Text("New Cardio")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                                
                    Spacer()
                    
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 36, height: 36)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 24)

                ScrollView {
                    VStack(spacing: 14) {
                        inputForm
                    }
                    .padding(.horizontal, 24)
                }
                
                Button(
                    action: {
                        addLog()
                        if !showAlert {
                            dismiss()
                        }
                    })
                {
                    Text("Add Workout")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color(red: 236/255, green: 106/255, blue: 112/255))
                        .cornerRadius(16)
                        .shadow(color: Color(red: 236/255, green: 106/255, blue: 112/255).opacity(0.3), radius: 12, x: 0, y: 6)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
            }
        }
        
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private var inputForm: some View {
        VStack(spacing: 6) {
            InputField(
                icon: "dumbbell.fill",
                placeholder: "Workout Title",
                text: $title
            )
            
            InputField(
                icon: "clock",
                placeholder: "Duration (minutes)",
                text: $duration
            )
            
            InputField(
                icon: "flame.fill",
                placeholder: "Calories",
                text: $calories
            )
            
            InputField(
                icon: "heart.fill",
                placeholder: "Max Heart Rate",
                text: $maxHeartRate
            )
            
            VStack(alignment: .leading, spacing: 8) {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.black.opacity(0.1)))
        .padding()
    }
    
    private func addLog() -> (Void) {
        guard !title.isEmpty || !duration.isEmpty || !calories.isEmpty || !maxHeartRate.isEmpty else {
            alertMessage = "All Fields Are Required"
            showAlert = true
            return
        }
        
        guard let durationInt = Int(duration), durationInt >= 0 else {
            alertMessage = "Enter a Valid Duration"
            showAlert = true
            return
        }
        
        guard let caloriesInt = Int(calories), caloriesInt >= 0 else {
            alertMessage = "Enter a Valid Calorie Count"
            showAlert = true
            return
        }
        
        guard let maxHRInt = Int(maxHeartRate), maxHRInt >= 0 else {
            alertMessage = "Enter a Valid Max Heart Rate"
            showAlert = true
            return
        }
        
        let calendar = Calendar.current
        let dayOfMonthInt = calendar.component(.day, from: selectedDate)
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "EEE"
        let dayOfWeekStr = formatter.string(from: selectedDate)
        
        let newCardio = Cardio(
            dayOfWeek: dayOfWeekStr,
            dayOfMonth: dayOfMonthInt,
            title: title,
            duration: durationInt,
            calories: caloriesInt,
            maxHeartRate: maxHRInt,
            date: selectedDate
        )
        
        onAdd(newCardio)
        showAlert = false
    }
}

struct InputField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(red: 236/255, green: 106/255, blue: 112/255))
                .frame(width: 24)
            
            TextField(placeholder, text: $text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
    }
}

// MARK: - Placeholder Extension

extension View {
    func placeholder<Content: View> (
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
