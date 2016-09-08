import Foundation

struct SmallThing: Hashable, Equatable, Comparable {
    let thing1: Int
    let thing2: Int
    let thing3: Int
    
    init(_ t1: Int, _ t2: Int, _ t3: Int) {
        thing1 = t1
        thing2 = t2
        thing3 = t3
    }
    
    var hashValue: Int {
        return thing1.hashValue + thing2.hashValue * 10000 + thing3.hashValue * 100000
    }
    
    static func == (lhs: SmallThing, rhs: SmallThing) -> Bool {
        return lhs.thing1 == rhs.thing1 
            && lhs.thing2 == rhs.thing2
            && lhs.thing3 == rhs.thing3
    }
    
    static func < (lhs: SmallThing, rhs: SmallThing) -> Bool {
        // ordering is due to the sum of the three things
        let lhsSum = lhs.thing1 + lhs.thing2 + lhs.thing3
        let rhsSum = rhs.thing1 + rhs.thing2 + rhs.thing3
        
        return lhsSum < rhsSum
    }
}




struct LargeThing: Hashable, Equatable, Comparable {
    let thing1: Int
    let thing2: Int
    let thing3: Int
    let thing4: Int
    
    init(_ t1: Int, _ t2: Int, _ t3: Int, _ t4: Int) {
        thing1 = t1
        thing2 = t2
        thing3 = t3
        thing4 = t4
    }
    
    var hashValue: Int {
        return thing1.hashValue + thing2.hashValue * 10000 + thing3.hashValue * 100000 + thing4.hashValue * 1000000
    }
    
    static func == (lhs: LargeThing, rhs: LargeThing) -> Bool {
        return lhs.thing1 == rhs.thing1 
            && lhs.thing2 == rhs.thing2
            && lhs.thing3 == rhs.thing3
            && lhs.thing4 == rhs.thing4
    }
    
    static func < (lhs: LargeThing, rhs: LargeThing) -> Bool {
        // ordering is due to the sum of the three things
        let lhsSum = lhs.thing1 + lhs.thing2 + lhs.thing3 + lhs.thing4
        let rhsSum = rhs.thing1 + rhs.thing2 + rhs.thing3 + rhs.thing4
        
        return lhsSum < rhsSum
    }
}


// TODO - show with bad hash function? That totally _exploded_ runtime
// and number of retains.
struct ReferenceThing: Hashable, Equatable, Comparable {
    let thing1: String
    
    init(_ t1: String) {
        thing1 = t1
    }
    
    var hashValue: Int {
        return thing1.hashValue
    }
    
    static func == (lhs: ReferenceThing, rhs: ReferenceThing) -> Bool {
        return lhs.thing1 == rhs.thing1 
    }
    
    static func < (lhs: ReferenceThing, rhs: ReferenceThing) -> Bool {
        // ordering is due to the first thing
        return lhs.thing1 < rhs.thing1
    }
}



struct CountingReferenceThing: Hashable, Equatable, Comparable {
    let thing1: CountingReferencer
    
    init(_ t1: CountingReferencer) {
        thing1 = t1
    }
    
    var hashValue: Int {
        return thing1.hashValue
    }
    
    static func == (lhs: CountingReferenceThing, rhs: CountingReferenceThing) -> Bool {
        return lhs.thing1.value ==  rhs.thing1.value
    }
    
    static func < (lhs: CountingReferenceThing, rhs: CountingReferenceThing) -> Bool {
        // ordering is due to the first thing
        return lhs.thing1.value < rhs.thing1.value
    }
}



