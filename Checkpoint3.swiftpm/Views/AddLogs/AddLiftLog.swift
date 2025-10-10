import SwiftUI

struct AddLiftLog: View {
    @Environment(\.dismiss) var dismiss // closes view
    var onAdd: (Lift) -> (Void)
    
    @State private var dayOfWeek: String = ""
    @State private var dayOfMonth: String = ""
    @State private var selectedDate: Date = Date()
    
    @State private var title: String = ""
    @State private var musclesHit: String = ""
    @State private var personalRecords: String = ""
    @State private var duration: String = ""
    
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color(red: 250/255, green: 250/255, blue: 252/255)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Button(
                        action: { dismiss() }
                    ) {
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
                    
                    Text("New Lift")
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
                    }
                ) {
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
            Alert(title: Text("Invalid"), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    // Add Log Components //
    
    private var inputForm: some View {
        VStack(spacing: 6) {
            InputField(
                icon: "dumbbell.fill",
                placeholder: "Workout Title",
                text: $title
            )
            
            InputField(
                icon: "figure.strengthtraining.traditional",
                placeholder: "Muscles Hit",
                text: $musclesHit
            )
            
            InputField(
                icon: "trophy.fill",
                placeholder: "Personal Records",
                text: $personalRecords
            )
            
            InputField(
                icon: "clock",
                placeholder: "Duration (minutes)",
                text: $duration
            )
            
            VStack(alignment: .leading, spacing: 8) {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .tint(Color(red: 236/255, green: 106/255, blue: 112/255))
                .labelsHidden()
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
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.black.opacity(0.1)))
        .padding()
    }
    
    private func addLog() -> (Void) {
        guard !title.isEmpty || !musclesHit.isEmpty || !personalRecords.isEmpty || !duration.isEmpty else {
            alertMessage = "All Fields Are Required"
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
        
        let calendar = Calendar.current
        let dayOfMonthInt = calendar.component(.day, from: selectedDate)
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "EEE" // e.g., Mon, Tue
        let dayOfWeekStr = formatter.string(from: selectedDate)
        
        let newLift = Lift(
            dayOfWeek: dayOfWeekStr,
            dayOfMonth: dayOfMonthInt,
            title: title,
            musclesHit: musclesHitInt,
            personalRecords: personalRecordsInt,
            duration: durationInt,
            date: selectedDate
        )
        
        onAdd(newLift)
        showAlert = false
    }
}
