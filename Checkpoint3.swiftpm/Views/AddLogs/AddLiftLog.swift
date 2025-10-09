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
            
            Text("New Lift").font(.largeTitle).bold()
            
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
            TextField("Title:", text: $title).padding(.horizontal)
            Divider().overlay(.white)
            TextField("Muscles Hit:", text: $musclesHit).padding(.horizontal)
            Divider().overlay(.white)
            TextField("PRs", text: $personalRecords).padding(.horizontal)
            Divider().overlay(.white)
            TextField("Duration:", text: $duration).padding(.horizontal)
            Divider().overlay(.white)
            DatePicker(
                "Select Date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            Divider().overlay(.white)
        }.padding()
        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.black)).padding()
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

