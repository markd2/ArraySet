import Foundation

final class FinalClass {
    var array = [Int]()
    func doNothing() {
    }
}

class NonFinalClass {
    var array = [Int]()
    func doNothing() {
    
    }
}

class NonFinalClass_FinalArray {
    final var array = [Int]()
    func doNothing() {
    
    }
}

class NonFinalClass_FinalMethod {
    var array = [Int]()
    final func doNothing() {
    }        
}


