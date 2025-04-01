import Foundation

//Является ли число простым?
func isPrime(_ number: Int) -> Bool {
    guard number > 1 else { return false }
    for i in 2..<(Int(sqrt(Double(number))) + 1) {
        if number % i == 0 {
            return false  
        }
    }
    return true
}

//Reverse строки
func reverseString(_ str: String) -> String {
    var reversed = ""
    for character in str {
        reversed = "\(character)" + reversed
    }
    return reversed
}

func isPalindrom(_ s: String) -> Bool {
    let characters = Array(s.lowercased())
    var left = 0
    var right = characters.count - 1
    while left < right {
        if characters[left] != characters[right] {
            return false
        }
        left += 1
        right -= 1
    }
    return true
}


func nonRepeat(_ input: String) -> String {
    for char in input {
        if input.firstIndex(of: char) == input.lastIndex(of: char) {
            return String(char)
        }
    }
    return ""
}

func firstNonRepeatingCharacter(in string: String) -> String {
    var dict = [Character: Int]()
    for el in string {
        dict[el, default: 0] += 1
    }
    for character in string {
        if dict[character] == 1 {
            return String(character)
        }
    }
    return ""
}


func checkAnagram(str1: String, str2: String) -> Bool {
    guard str1.count == str2.count else {
        return false
    }
    
    // lowercase first then used sorted() function, it will return array of characters sorted
     // ["a","b","с","d","e",f"]
    if str1.lowercased().sorted() == str2.lowercased().sorted() {
        return true
    }
    return false
}
print(checkAnagram(str1: "nba", str2: "abn"))
    
    
    
func checkAnagram1(str1: String, str2: String) -> Bool {
    var dict: [Character: Int] = [:]
    for char in str1 {
        dict[char, default: 0] += 1
    }
    
    for char in str2 {
        dict[char, default: 0] += 1
    }
  
    for (_, val) in dict {
        if val != 0 {
            return false
        }
    }
    return true
}

///находит длину самой длинной подстроки в строке `s`, которая не содержит повторяющихся символов.

func lengthOfLongestSubstring(_ s: String) -> Int  {
    var start = 0
    var maxLength = 0
    var charToIndex = [Character: Int]()
    for (i, char) in s.enumerated() {
        if let index = charToIndex[char] {
            // If the character is already present in the charToIndex dictionary, move the start index to the next of the previous occurrence of the character.
            start = max(start, index + 1)
        }
        charToIndex[char] = i
        maxLength = max(maxLength, i - start + 1)
    }
    return maxLength
}
lengthOfLongestSubstring("abcabcbb")



func getReverseNumber (value: Int) -> Int {
    var x = value
    var result = 0
    while (x != 0) {
        result = result * 10 + x % 10
        x = x / 10;
    }
    return result
}


///находит и возвращает самый часто встречающийся символ в строке, переданной ей в качестве параметра. Если строка пуста, функция возвращает `nil`.

func returnMostCommonCharacter(string: String) -> Character? {
    guard !string.isEmpty else { return nil }

    var characters = Array(string.lowercased())
    var dict = Dictionary<Character, Int>()
    var maxCharacter: Character?
    var maxCount = 0

    for character in characters {
        dict[character, default: 0] += 1

        if dict[character]! > maxCount {
            maxCharacter = character
            maxCount = dict[character]!
        }
    }
    
    return maxCharacter
}



func longestCommonPrefix(_ strs: [String]) -> String {
    guard !strs.isEmpty else { return "" }
    
    var key = ""
    let firstString = strs[0]
    
    for i in 0..<firstString.count {
        let index = firstString.index(firstString.startIndex, offsetBy: i)
        let char = firstString[index]
        
        for item in strs {
            if item.count < i + 1 || item[item.startIndex...item.index(item.startIndex, offsetBy: i)] != firstString[item.startIndex...index] {
                return key
            }
        }
        
        key.append(char)
    }
    
    return key
}
 
class MyGenericClass<Value> {
    var value: Value
    
    init(_ value: Value) {
        self.value = value
    }
    
    convenience init?(_ value: Value?) {
        switch value {
        case .some(let unwrapped):
            self.init (unwrapped)
        case .none:
            return nil
        }
    }
}


extension MyGenericClass where Value == Int {
    func doSomething () {}
}

//Optional Generic inferring
var num: Int? = 12
let myClass = MyGenericClass(num) // => Optional MyGenericClass<Int>
//myClass?. doSomething ()
//Regular Generic inferring
var num2: Int = 10
let myClass2 = MyGenericClass (num2) // => Non-Optional MyGenericClass<Int>
//myClass2.doSomething()
//Regular Generic with Optional value
var num3: Int? = 15
let myClass3 = MyGenericClass<Optional<Int>>(num3) // Non-Optional MyGenericClass<Opti


