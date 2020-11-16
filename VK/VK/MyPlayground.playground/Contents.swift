protocol Coffee {
    var cost: Int { get }
}

class SimpleCoffee: Coffee {
    var cost: Int {
        return 10
    }
}

protocol CoffeeDecorator: Coffee {
    var base: Coffee { get }
    init(base: Coffee)
}

class MilkCoffee: CoffeeDecorator {
    let base: Coffee
    
    var cost: Int {
        return base.cost + 5
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}

class SyropCoffee: CoffeeDecorator {
    let base: Coffee
    
    var cost: Int {
        return base.cost + 3
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}

class SugarCoffee: CoffeeDecorator {
    let base: Coffee
    
    var cost: Int {
        return base.cost + 1
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}
class WhipCoffee: CoffeeDecorator {
    let base: Coffee
    
    var cost: Int {
        return base.cost + 2
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}


let coffee = SimpleCoffee()
let milkCoffee = MilkCoffee(base: coffee)
let sugarCoffee = SugarCoffee(base: coffee)
let milkSugarCoffee = SugarCoffee(base: milkCoffee)

print(coffee.cost)
print(milkCoffee.cost)
print(sugarCoffee.cost)
print(milkSugarCoffee.cost)
