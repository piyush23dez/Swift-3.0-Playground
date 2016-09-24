
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


//Network operation
func fetchData() {}

//Create a concurrent queue
let concurrentQueue = DispatchQueue(label: "concurrent", qos: .background, attributes: .concurrent)

//Perform concurrent operation asynchronously
concurrentQueue.async {
   
    //Background operation
    fetchData()
    
    //Get main queue asynchronously to update ui
    DispatchQueue.main.async {}
}

//Create a global queue
let globalQueue = DispatchQueue.global(qos: .background)

//Perform concurrent operation asynchronously
globalQueue.async {
    //Background operation
    fetchData()
    
    //Get main queue asynchronously to update ui
    DispatchQueue.main.async {}
}

//Create a serial queue
let serialQueue = DispatchQueue(label: "serial")

//Perform serial operation asynchronously
serialQueue.async {
    //Background operation
    fetchData()
    
    //Get main queue asynchronously to update ui
    DispatchQueue.main.async {}
}

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
    
    //lazy property
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
}

//Closures


//Example1
var hello: () -> String = {
    return "hello swift"
}
hello()



//Example2
var double: (Int) -> Int = { value in
    return 2 * value
}
double(5)



//Example3
let anotherDouble = double
anotherDouble(4)



//Example4
var printString: () -> () = {
    print("Print closure")
}
printString()



//Example5
var getNumber: () -> Int = {
    return 100
}



//Example6
var mod: (Int) -> Int = { value in
    return value%10
}
mod(15)



//Example7
var concatString: (String, String) -> String = { (first: String, second: String) in
   return first + " " + second
}
concatString("Hi", "There")



//Example8
var doubleValue: (Int) -> Int = {
   return $0 * 2
}
doubleValue(2)




//Example9
var sum: (Int, Int) -> Int = {
    return $0 + $1
}
sum(1, 1)




/* So a closure can remember the reference of a variable or constant from its context and
use it when it’s called. closure captures a variable that is not in the global context */

//Example10
func makeIterator(start: Int, step: Int) -> () -> Int {
    
    var index = start
    
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




//Example11
func makeMultiplier(multiplier: Int) -> (Int) -> Int {
    
    let closure: (Int) -> Int = { (input: Int) in
        return input * multiplier
    }
    return closure
}

let doubler = makeMultiplier(multiplier: 2)
doubler(10)

let tripler = makeMultiplier(multiplier: 3)
tripler(10)




//Example12
let incrementor: (Int) -> Int = { input in
    return input+1
}
incrementor(10)




//Example13
func getSum(from: Int, to: Int, function: (Int) -> Int) -> Int {
    var sum = 0
    
    for i in from...to {
        sum += function(i)
    }
    return sum
}
let total = getSum(from: 1, to: 5) { $0 }
print(total)



/* Write a function named applyKTimes that takes an integer K and a closure and calls the
   closure K times. The closure will not take any parameters and will not have a return 
   value.
   Hint: Remember a closure is just like a regular function.
*/

func applyKTimes(k: Int, closure: () -> ()) {
    closure()
}

applyKTimes(k: 5) {
    print("piyush")
}


/* Find the largest number using reduce 
   Hint: choose initial value for reduce function
*/

let allNumbers = [4, 7, 1, 9, 6, 5, 6, 9]
let max = allNumbers.reduce(allNumbers[0]) {
    
    if $0 > $1 {
        return $0
    }
    else {
        return $1
    }
}
max


/* Join all the strings from strings into one using reduce. Add spaces in between 
   strings. Print your result.
*/

let strArray = ["Hi", "There"]
let totalString = strArray.reduce("") {
    
    //if array contains only one string
    if $0 == "" {
        return $1
    }
    else {
        return $0 + " " + $1
    }
}
totalString




//Example19
var someArray = [1, 2, 3, 4, 5, 6]

someArray.sort { x, y in
    
    func countDivisors(number: Int) -> Int {
        var count = 0
        for index in 1...number where number%index == 0 {
            count += 1
        }
        return count
    }
    return countDivisors(number: x) < countDivisors(number: y)
}
print(someArray)