
import UIKit
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}

extension Color {
    static let twitterBlue = Color(red: 29/255, green: 161/255, blue: 242/255)
}
