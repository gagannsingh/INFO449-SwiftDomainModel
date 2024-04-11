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
    func raise(byAmount: Double) {
            switch type {
            case .Hourly(let wage):
                type = .Hourly(wage + byAmount)
            case .Salary(let salary):
                type = .Salary(salary + UInt(byAmount))
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

    }


////////////////////////////////////
// Person
//
public class Person {
    
    
}

////////////////////////////////////
// Family
//
public class Family {
}
