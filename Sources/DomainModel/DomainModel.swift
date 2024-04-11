struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount: Double
    var currency: String
    
    init(amount: Double, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    func convert(_ toCurrency: String) -> Money {
        var convertedAmount = amount
        switch (currency, toCurrency) {
            case ("USD", "GBP"):
                convertedAmount /= 2
            case ("USD", "EUR"):
                convertedAmount *= 1.5
            case ("USD", "CAN"):
                convertedAmount *= 1.2
            case ("GBP", "USD"):
                convertedAmount *= 2
            case ("EUR", "USD"):
                convertedAmount /= 1.5
            case ("CAN", "USD"):
                convertedAmount /= 1.2
            default:
                break
        }
        return Money(amount: convertedAmount, currency: toCurrency)
    }
    
    func add(_ money: Money) -> Money {
        if currency == money.currency {
            return Money(amount: amount + money.amount, currency: currency)
        } else {
            let convertedMoney = money.convert("USD")
            return Money(amount: amount + convertedMoney.amount, currency: currency)
        }
    }
    
}

////////////////////////////////////
// Job
//
public class Job {
    let title: String
    var type: JobType
    
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    func calculateIncome(_ hours: Int) -> Int {
        switch type {
        case .Hourly(let wage):
            return Int(wage * Double(hours))
        case .Salary(let salary):
            return Int(salary)
        }
    }
    func raise(byPercent: Double){
        switch type {
        case .Hourly(let wage):
            let raiseFactor = 1.0 + byPercent
            let newWage = wage * raiseFactor
            type = .Hourly(newWage)
        case .Salary(let salary):
            let raiseFactor = 1.0 + byPercent
            let newSalary = Double(salary) * raiseFactor
            type = .Salary(UInt(newSalary))
        }
    }
    
    func raise(byAmount: Double) {
            switch type {
            case .Hourly(let wage):
                type = .Hourly(wage + byAmount)
            case .Salary(let salary):
                type = .Salary(salary + UInt(byAmount))
            }
        }
    }

////////////////////////////////////
// Person
//
public class Person {
    var firstName: String
    var lastName: String
    var age: Int
    private var _job: Job?
    private var _spouse: Person?
    var job: Job? {
            get {
                return _job
            }
            set {
                if age < 16 {
                    _job = nil
                } else {
                    _job = newValue
                }
            }
        }

        var spouse: Person? {
            get {
                return _spouse
            }
            set {
                if age < 18 {
                    _spouse = nil
                } else {
                    _spouse = newValue
                }
            }
        }
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self._job = nil
        self._spouse = nil
    }
  
    func toString() -> String {
        let jobString = job != nil ? "\(job!)" : "nil"
        let spouseString = spouse != nil ? "\(spouse!.firstName) \(spouse!.lastName)" : "nil"
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(jobString) spouse:\(spouseString)]"
    }
}


////////////////////////////////////
// Family
//
public class Family {
    var members : [Person] = []
    
    init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
        }
    }
    
    func householdIncome() -> Int {
        var famIncome = 0
        for person in members{
            let work = person.job
            if (work !== nil) {
                famIncome += work!.calculateIncome(2000)
            }
        }
        return famIncome
    }
    
    func haveChild(_ kid: Person) -> Bool {
        if members[0].age > 21 || members[1].age > 21 {
            members.append(kid)
            return true
        }
        return false
    }
}
