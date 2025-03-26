 

import Foundation

/// Функция для перевода буквы в ASCII код
func letterToASCII(letter: Character) -> Int? {
    if let scalar = letter.unicodeScalars.first {
        return Int(scalar.value)
    }
    return nil
}

/// Функция для перевода ASCII кода в букву
func asciiToLetter(ascii: Int) -> Character? {
    guard let scalar = UnicodeScalar(ascii) else { return nil }
    return Character(scalar)
}
 
let letter: Character = "a"
if let asciiValue = letterToASCII(letter: letter) {
    print("ASCII для \(letter) == \(asciiValue)")
}

if let newLetter = asciiToLetter(ascii: 97) {
    print("Буква для ASCII 97 == \(newLetter)")
}
