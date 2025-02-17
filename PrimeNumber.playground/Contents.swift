import Foundation


func isPrime(_ number: Int) -> Bool {
    guard number > 1 else { return false }
    for i in 2..<(Int(sqrt(Double(number))) + 1) {
        if number % i == 0 {
            return false  
        }
    }
    return true
}
