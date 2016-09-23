
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

