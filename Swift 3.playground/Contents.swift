
import UIKit

/*
 Swift functions are first class types, This means that we can assign functions to
 variables, pass them as parameters to other functions, or make them return types
 */

//Example 1
func compareGreaterThan(a: Int, b: Int) -> Bool {
    return a > b
}

func compareLessThan(a: Int, b: Int) -> Bool {
    return a < b
}

func comparator(isGreaterThan: Bool) -> ((Int, Int) -> Bool) {
    
    if isGreaterThan {
        return compareGreaterThan
    }
    else {
        return compareLessThan
    }
}

//let f1 = comparator(isGreaterThan: true)
//print(f1(4,3))


//Example 2
func stringLength(str: String) -> Int {
    return str.characters.count
}

func stringValue(str: String) -> Int {
    
    if let intValue = Int(str) {
        return intValue
    }
    return 0
}

func doSomething(function: (String) -> Int, str: String ) -> Int {
    return function(str)+1
}

let f1 = stringLength
let f2 = stringValue

let v1 = doSomething(function: f1, str: "123")
let v2 = doSomething(function: f2, str: "123")

print(v1)
print(v2)



//Enum
enum Location {
    case Address(street: String, city: String)
    case LatLong(lat: Double, long: Double)
    
    var description: String {
        switch self {
        case .Address(let street, let city):
            return street + ", " + city
        case .LatLong(let lat, let long):
            return "\(lat), \(long)"
        }
    }
}

let location = Location.Address(street: "94 Adams St", city: "Waltham")
print(location.description)

let latLong = Location.LatLong(lat: 41.45, long: -71.90)
print(latLong.description)


//Tuples are extremely convenient as return types for functions that need to return more than one value:

let person = (firstName: "Piyush", lastName: "Sharma")
print(person.firstName)

func intDivision(a: Int, b: Int) -> (quotient: Int, reminder: Int) {
    return (a/b, a%b)
}

let result = intDivision(a: 15, b: 5)
print(result.quotient)


//Pattern matching using Tuples
let complex = (1, 1)

switch complex {
    
// real and imaginary parts
case (0, 0):
    print("Number is zero")
case (let a, 0) where a > 0:
    print("Number is real and positive")
case(let a, 0) where a < 0:
    print("Number is real and negative")
case(0, let b) where b != 0:
    print("Number has only imaginary part")
case let (a,b):
    print("number is imaginary with distance \(a*a + b*b)")
}

//For loops
for index in 1...5 {
    print(index)
}

(6...10).forEach {
    print($0)
}






//Closures in swift 3.0


//Example1 - closure takes no parameter, return value is a string
var hello: () -> String = {
    return "hello swift"
}
hello()



//Example2 -  closure takes 1 parameter, return value is an Int
var double: (Int) -> Int = { value in
    return 2 * value
}
double(2)


//Example3 - assign closure to another variable
let anotherDouble = double
anotherDouble(4)



//Example4 - closure takes no parameter, no return value
var printString: () -> () = {
    print("Print closure")
}
printString()



//Example5 - closure takes no parameter, return value is an Int
var getNumber: () -> Int = {
    return 100
}
getNumber()


//Example6 - closure takes 1 parameter, return value is an Int
var mod: (Int) -> Int = { value in
    return value % 10
}
mod(15)



//Example7 - closure takes 2 parameter as String, return value is a String
var concatString: (String, String) -> String = { (first: String, second: String) in
   return first + " " + second
}
concatString("Hi", "There")



//Example8 - closure takes 2 parameter as Int, return value is an Int
var sum: (Int, Int) -> Int = {
    return $0 + $1
}
sum(1, 1)




/* a closure can remember the reference of a variable or constant from its context and
use it when it’s called. closure captures a variable that is not in the global context */

//Example8
func makeIterator(start: Int, step: Int) -> () -> Int {
    
    var index = start
    
    //closure takes no parameter, return value is an Int
    let incrementer: () -> Int = {
        let currentValue = index
        index += step
        return currentValue
    }
    return incrementer
}

var iterator = makeIterator(start: 1, step: 1)
iterator()
iterator()
iterator()




//Example9 - function takes one parameter, return value is a closure

func makeMultiplier(multiplier: Int) -> (Int) -> Int {
    
    //closure takes 1 Int parameter, return type is an Int
    let closure: (Int) -> Int = { (input: Int) in
        return input * multiplier
    }
    return closure
}

let doubler = makeMultiplier(multiplier: 2)
doubler(10)

let tripler = makeMultiplier(multiplier: 3)
tripler(10)



//Example10 - func takes 2 Int parameters and a closure, return value is an Int
//closure takes 1 Int parameter and return type is an Int

func getSum(from: Int, to: Int, closure: (Int) -> Int) -> Int {
    
    var sum = 0
    
    for index in from...to {
        sum += closure(index)
    }
    return sum
}
let total = getSum(from: 1, to: 5) { $0 }
print(total)


//Example11

/* Write a function named applyKTimes that takes an integer K and a closure and calls the
   closure K times. The closure will not take any parameters and will not have a return 
   value.
   Hint: Remember a closure is just like a regular function.
*/

func applyKTimes(k: Int, closure: () -> ()) {
    
    for _ in 1...k {
        closure()
    }
}

applyKTimes(k: 5) {
    print("Printing 5 times")
}


//Example12

/* Find the largest number using reduce with or without max func of swift */

let allNumbers = [4, 7, 1, 11, 6, 5, 6]
let maxValue = allNumbers.reduce(0) {
    
    if $0 > $1 {
        return $0
    }
    else {
        return $1
    }
}
maxValue

let maxNum = allNumbers.reduce(0, max)
maxNum


//Example13

/* Join all the strings from strings into one using reduce. Add spaces in between 
   strings. Print your result.
*/

let strArray = ["Hi", "There"]
let totalString = strArray.reduce("") {
    
    //if array contains only one string
    if $0.isEmpty {
        return $1
    }
    else {
        return $0 + " " + $1
    }
}

totalString

let newString = strArray.reduce("") { text, name in
    
    if text.isEmpty {
        return name
    }
    else {
        return "\(text) , \(name)"
    }
}
newString




//Example14 - sort array in ascending order by number of divisors for each value
var someArray = [1, 2, 3, 4, 5, 6]

//sort in place
someArray.sort { x, y in
    
    func countDivisors(number: Int) -> Int {
        var count = 0
        for index in 1...number where number % index == 0 {
            count += 1
        }
        return count
    }
    return countDivisors(number: x) < countDivisors(number: y)
}
print(someArray)





//Example15

var numbersArr = [1, 2, 3, 4, 5, 6]
/*  Find the sum of the squares of all the odd numbers from numbers and then print it. Use map, filter and reduce to solve this problem.
*/
let sumOfNumbs = numbersArr.filter { $0 % 2 == 1 }.map { $0 * $0 }.reduce(0, +)




//Example16

/* Implement a function forEach(array: [Int], _ closure: Int -> ()) that takes an array
   of integers and a closure and runs the closure for each element of the array.
*/

func forEach(array: [Int], closure: (Int) -> ()) {
    
    for number in array {
        closure(number)
    }
}

forEach(array: [1,2,3,4,5]) { (value) in
   print(value * value)
}




//Example17

/*
 Implement a function combineArrays that takes 2 arrays and a closure that combines 2 
 Ints into a single Int. 
 
 The function combines the two arrays into a single array using
 the provided closure. Assume that the 2 arrays have equal length.
*/

func combine(array1: [Int], array2: [Int], closure: (Int, Int) -> Int) -> [Int] {
    
    var result = [Int]()
    
    for i in 0..<array1.count {
        result.append(closure(array1[i], array2[i]))
    }
    return result
}

let arr1 = [1,2,3]
let arr2 = [4,5,6]

combine(array1: arr1, array2: arr2) { (value1, value2) -> Int in
    return value1 * value2
}


//Example 18

let collections = [[5,2,7],[4,8],[9,1,3]]
let flat = collections.flatMap { $0 }
flat

let onlyEven = collections.flatMap {
    $0.filter { $0 % 2 == 0 }
}
onlyEven


let numbers = [20,17,35,4,12]
let evenSquares = numbers.map { $0 * $0 } .filter { $0 % 2 == 0 }
evenSquares





/*---------------------------------------------------*/

//Memory Management

class Car {
    var plate: String
    weak var driver: Driver?
    
    init?(plate: String) {
        self.plate = plate
    }
    
    deinit {
        print("Car deinit")
    }
}

class Driver {
    let name: String
    var cars = [Car]()
    
    init?(name: String) {
        self.name = name
    }
    
    //lazy stored property
    lazy var carNumberPlatesString: String = {
        return self.cars.map {$0.plate}.joined(separator: ", ")
    }()
    
    //lazy closure property
    lazy var allPlates: () -> String = { [unowned self] in
        return self.cars.map{ $0.plate}.joined(separator: ", ")
    }
    
    deinit {
        print("Driver deinit")
    }
}

do {
    let car = Car(plate: "abc")
    let driver = Driver(name: "jack")
    
    car?.driver = driver
    driver?.cars.append(car!)
    print(driver?.allPlates())
}
/*---------------------------------------------------*/


//Swift – Reading files from disk

func read() {
 if let filePath = Bundle.main.path(forResource: "urls", ofType: "plist") {
   do {
     let contents = try Dictionary(contentsOfFile: filePath)
   }
  catch let error {
    print("contents could not be loaded: \(error)")
  }
 }
 else {
  print("Fil not found")
 }
}

//Swift – Writing files to disk

func write(data: Dicionary) {
 let path = getDocumentDirectoryPath(fileName: "urls.plist")
  do {
   try data.write(to: path, atomically: false, encoding: String.encoding.utf8)
  }
  catch let error {
   print("error in writing data to disk")
  }
}

func getDocumentDirectoryPath(fileName: String) -> String {
 let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
 let path = dir.appendingPathComponent(fileName)
 return path
}
 

/*---------------------------------------------------*/


//Swift – Json serialization

func getJson() -> [String : Any] {
 let jsonString = "some json string from server"
 
 let data = jsonString.data(using: .utf8)!
 let json = try ? JSONSerialization.jsonObject(with: data)
 return json
}








