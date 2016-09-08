import Foundation

protocol DoNothing {
    func doNothing()
}


protocol DoNothing_OneUse {
    func doNothing()
}


protocol DoesSomething {
    func doStuff()
}



// Consume an int
func Sink(_ arg: Int) {
    _ = arg
} 

var doStuffWithCount = 0
func DoStuffWithNothing(_ nothing: DoNothing) {
    doStuffWithCount += 1
    nothing.doNothing()
}

func DoStuffWithNothing(_ nothing: SmallDoNothing) {
    doStuffWithCount += 1
    nothing.doNothing()
}

func DoStuffWithNothing(_ nothing: LargeDoNothing) {
    doStuffWithCount += 1
    nothing.doNothing()
}

func DoStuffWithNothing(_ nothing: DoNothing_OneUse) {
    doStuffWithCount += 1
    nothing.doNothing()
}

func DoStuffWithNothing(_ nothing: LargeDoNothing_OneUse) {
    doStuffWithCount += 1
    nothing.doNothing()
}

struct SmallDoNothing: DoNothing {
    var x = 0, y = 0
    
    func doNothing() {
        Sink(x + y)
    }
}


struct LargeDoNothing: DoNothing {
    var x = 0, y = 0, z = 0, a = 0, b = 0, c = 0
    func doNothing() {
        Sink(x + y +  z + a + b + c)
    }
}


class ClassDoNothing: DoNothing {
    var x = 0, y = 0, z = 0, a = 0, b = 0, c = 0
    func doNothing() {
        Sink(x + y +  z + a + b + c)
    }
}


struct LargeDoNothing_OneUse: DoNothing_OneUse {
    var x = 0, y = 0, z = 0, a = 0, b = 0, c = 0
    func doNothing() {
        Sink(x + y + z + a + b + c)
    }
}

