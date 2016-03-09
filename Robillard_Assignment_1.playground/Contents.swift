//: Playground - noun: a place where people can play

import UIKit

//Optionals
var optionalString : Optional<String>
var optionalString2 : String?

print(optionalString)
print(optionalString2)

//unwrapping optionals
func generalFunction(something : String?)
{
    //unwrap using the ! character
    print(something!)
}

generalFunction("Hello World")
//cannot do this generalFunction(optionalString)
//there is no value to unwrap

var possibleString : String? = "possible"
//type optional string
var absolutelyString = possibleString!
//type String because possibleString isn't nil

//nil checks
if possibleString != nil
{
    possibleString!.uppercaseString
}

//alternatively in one line
possibleString?.uppercaseString

//if passing an optional into a function, need to unwrap first to pass in raw string
func toUppercase(string : String) -> String
{
    var newString : String
    newString = string.uppercaseString
    return newString
}

toUppercase("mississippi")
//necessary to unwrap
toUppercase(possibleString!)

//comparing optionals
let s1 : String! = "Matt"
let s2 : String? = "Matt"
s1 == s2
//true

class Person
{
    var name : String?
    var age : Int?
    //can use optionals to create variables without a declaration
    
    func talk()
    {
        print("hello")
    }
}

let p = Person()
p.name = "Matt"
p.name?.uppercaseString //checks for nil, then unwraps and executes
p.age?.successor() //returns a nil

//conditionally unwrapping
var name : String?
let upperCase = name?.uppercaseString
upperCase.dynamicType
//use ? instead of ! 

var p2 : Person? = nil
p2?.talk() //conditionally call method, if nil, nothing happens
p2 = Person()
p2?.name?.lowercaseString //conditionally unwrap dog and name

//comparing optional and non-optional
let s3 : String? = "hello"
//optional and nil
s3 == nil
//optional with non optional
s3 == "hello"
//if optional wraps value, it is unwrapped and compared
//optional with optional
let s4 : String? = nil
s3 == s4
let s5 : String? = "hello"
s3 == s5

//Object Types
class Message
{
    class func MessageHappily(person : String)
    {
        print("Nice day isn't it \(person)?")
    }
    class func MessageAngrily(person : String)
    {
        print("How dare you \(person)!")
    }
}

//class methods
Message.MessageHappily("Matt")
Message.MessageAngrily("Matt")

class Cat
{
    var name : String
    var age : Int
    
    //failable initializer, same as normal initializer but with a ? or ! token
    init?(name : String, age : Int = 0)
    {
        self.name = name
        self.age = age
        
        if age < 0
        {
            return nil
        }
        
        self.pur()
    }

    func pur()
    {
        print("purrrrr")
    }
}

var c = Cat(name: "Chloe", age: 9)
var negativeCat = Cat(name: "Charles", age: -10)
negativeCat?.pur()

//subscripts
class Month
{
    private var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    subscript(idx: Int) -> String
    {
        return months[idx]
    }
}

let summerVacation = Month()
print("I have summer vacation during \(summerVacation[6]) and \(summerVacation[7])")

class Number
{
    var num : Int
    
    init(num: Int)
    {
        self.num = num
    }
    
    subscript(idx : Int) -> Int
    {
        get{
            let numString = String(num)
            return Int(String(numString.characters[numString.startIndex.advancedBy(idx)]))!
            //converts Int to string, then pulls out the character of the string based on the idx
        }
        set{
            var originalNumString = String(num)
            
            let range = originalNumString.startIndex.advancedBy(idx)..<originalNumString.startIndex.advancedBy(idx + 1)
            originalNumString.replaceRange(range, with: String(newValue))
            
            self.num = Int(originalNumString)!
        }
    }
}
let num = Number(num: 2345)
num[2]
num[0] = 3
num

//enums
enum CarType
{
    case Dodge
    case Subaru
    case Tesla
}

let type = CarType.Dodge

//can have a raw type
enum EngineType : String
{
    case Dodge = "v8"
    case Tesla = "Electric"
}

let engineTypeStr = "v8"
let engineType = EngineType(rawValue: engineTypeStr) //evals to optional
let unknownType = EngineType(rawValue: "Electric") //if unrecognized, evaluates to a nil

//Structs vs classes
struct Dog
{
    var name : String
    var age : Int
}

//class Cat from earlier
var c1 = Cat(name: "Chloe")
let d1 = Dog(name: "Rover", age: 0)

//classes are reference types
c
c1
c1 = c

//structs are value types
var d2 = d1
d2.name = "Fido"
d1

class Biped
{
    var name : String
    var age : Int
    
    init(name : String, age : Int = 0)
    {
        self.name = name
        self.age = age
    }
    
    convenience init()
    {
        //delegates to designated initalizers
        self.init(name : "", age : 0)
    }
    
    func walk()
    {
        print("walking... step, step")
    }
}

class Toddler : Biped
{
    final override func walk()
    {
        super.walk()
        print("waddle waddle")
    }
    
    func cry()
    {
        print("wahhh")
    }
}

final class Adult : Biped
{
    func smallTalk()
    {
        print("blah blah blah")
    }
}

let matt = Adult(name: "Matt", age: 22)
matt.walk()
matt.smallTalk()

let timmy = Toddler(name: "Timmy", age: 4)
timmy.walk()
timmy.cry()

class SuperToddler : Toddler
{
    //can't override walk()
    override func cry()
    {
        print("I'm super crying")
    }
}

//can't subclass a final class

class AngryCat : Cat
{
    override func pur()
    {
        super.pur()
        super.pur()
        super.pur()
    }
    
    func hiss()
    {
        print("hissss")
    }
}

let regularCat = Cat(name: "Harris")
let angryCat = AngryCat(name: "Mr. Whiskers")

func makeCatPur(cat : Cat)
{
    cat.pur()
    
    //optionally cast to AngryCat
    //possible to return a nil
    let angryCat = cat as? AngryCat
    
    angryCat?.hiss()
}

makeCatPur(regularCat!)
makeCatPur(angryCat!)

//Protocols and Extensions
protocol Crawler
{
    var numberOfLegs : Int { get }
    
    func crawl()
    
    func crawlUpLeg() -> Void
}

//unable to create an instance of a protocol

class Spider : Crawler
{
    var numberOfLegs : Int = 8
    
    func crawl()
    {
        print("I'm creepin and crawlin")
    }
    
    func crawlUpLeg()
    {
        print("I'm crawling up your leg")
    }
}

struct Centipede : Crawler
{
    var numberOfLegs : Int = 100
    
    func crawl()
    {
        print("I'm crawling")
    }
    
    func crawlUpLeg()
    {
        print("You don't want me to do that")
    }
}

let spider = Spider()
let cent = Centipede()

func howManyLegs(c : Crawler)
{
    print("I have \(c.numberOfLegs) legs")
    c.crawl()
}

howManyLegs(spider)
howManyLegs(cent)

//umbrella types

func anyObjectExpect(obj : AnyObject) {}
func anyClassExpect(cls: AnyClass) {}
func anyExpect(a: Any) {}

anyObjectExpect("hey there")
anyObjectExpect(spider)
//cannot take types ie anyObjectExpect(Int)

anyClassExpect(Cat)

anyExpect("")
anyExpect(Centipede)

//Extensions

var str = "Hello there, I'm Matt"

str.characters[str.startIndex.advancedBy(2)]

extension String
{
    subscript(idx : Int) -> Character
    {
        return Array(self.characters)[idx]
    }
    
    func doAThing()
    {
        print("a thing")
    }
}

str[7]
str.doAThing()

//Error Handling
enum MyErrors : ErrorType
{
    case MinorMistake
    case MajorMistake
    case FatalMistake
}

func errorTest()
{
    do{
        throw MyErrors.MajorMistake
    }
    catch MyErrors.MinorMistake{
        print("minor mistake")
    }
    catch MyErrors.MajorMistake{
        print("major mistake")
    }
    catch MyErrors.FatalMistake{
        print("fatal mistake")
    }
    catch {
        print("Everything else")
        //catch everything
}
}

func divide(num1 : Int, num2 : Int) throws
{
    if num2 == 0
    {
        throw MyErrors.FatalMistake
    }
    else
    {
        print(num1/num2)
    }
}

do{
    try divide(2, num2: 0)
}
catch {
    print("these can't be divided")
}

//Collection Types
//Arrays
var a : [Int]
a = [2,3,4,5]
a.startIndex
a.popLast()
a.contains(3)
a.indexOf(4)
a.append(6)
a.popLast()

//Dictionaries
var dict : [Int: String]
dict = [0: "0", 2: "2"]
dict.count
dict[30] = "30"

let subset = dict.filter { (id, name) -> Bool in
    return name.containsString("0")
}

//switch
enum OSType
{
    case Linux
    case Windows
    case Mac
}

let osType : OSType = .Linux

switch osType
{
case .Linux:
    print("hooray linux")
case .Windows:
    print("...windows 10?")
case .Mac:
    print("I wish this was cheaper")
default:
    print("none")
}

//ternary operator
var num8 = 123
let spec = (num8 < 0) ? "negative" : "nonnegative"

//array of dogs
let d4 = Dog(name: "Rover", age: 12)
let d5 = Dog(name: "Buddy", age: 8)
let d6 = Dog(name: "Thor", age: 2)
let d7 = Dog(name: "Griffin", age: 6)

let dogArray : [Dog] = [d4, d5, d6, d7]

for dog in dogArray where dog.age < 7
{
    print(dog.name)
}

dogArray.forEach { (d) -> () in
    print(d.name)
}
