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
        VStack {
            HStack {
                Button(
                    action: { dismiss() },
                    label: { Label("", systemImage: "chevron.left") }
                )
                Spacer()
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 10))
            
            Text("New Cardio").font(.largeTitle).bold()
            
            inputForm
            
            Button(
                action: {
                    addLog()
                    if !showAlert {
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
    
    private var inputForm: some View {
        VStack {
            TextField("Title:", text: $title).padding(.horizontal)
            Divider().overlay(.white)
            TextField("Duration:", text: $duration).padding(.horizontal)
            Divider().overlay(.white)
            TextField("Calories:", text: $calories).padding(.horizontal)
            Divider().overlay(.white)
            TextField("Max Heart Rate:", text: $maxHeartRate).padding(.horizontal)
            Divider().overlay(.white)
            DatePicker(
                "Select Date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            Divider().overlay(.white)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.black))
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
