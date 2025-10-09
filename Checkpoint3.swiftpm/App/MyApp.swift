import SwiftUI

@main
struct MyApp: App {
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().backgroundColor = .black
        let normalAttrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        let selectedAttrs = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(normalAttrs, for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes(selectedAttrs, for: .selected)
        
        UIDatePicker.appearance().tintColor = .white // accent highlight
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
