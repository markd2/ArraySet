import Cocoa


// ------------------------------------------------------------
// MARK: - Helper Functions

// Two faces just eat the code.  Take off one face to run it.

func 🤓🤓(thing: () -> Void) {
}

func 🤓(thing: () -> Void) {
    print("")
    thing()
}



// ------------------------------------------------------------

// MARK: - Reference Counting
🤓🤓 {
    CountingReferencer.clearRetainCounts()

    struct StructWithReferencer {
        // objc helper class that counts `retain`s
        let thing1: CountingReferencer = CountingReferencer()
    }

    let refStruct = StructWithReferencer()
    
    let count = 10_000
    var refArray = [StructWithReferencer]()
    
    for _ in 0 ..< count {
        refArray.append(refStruct)
    }
    
    print("after adding \(count) items: \(CountingReferencer.numberOfRetains()) retains")
}


// ------------------------------------------------------------

// MARK: - Modify in place

🤓🤓 {
    let appendCount = 100_000
    
    func append_one(_ a: [Int]) -> [Int] {
        var a = a
        a.append(1)
        return a
    }
    
    var array = [Int]()
    let appendCopyTime = BNRTimeBlock {
        for _ in 0 ..< appendCount {
            array = append_one(array)
        }
    }
    
    print("append_one (copy    ) time \(appendCopyTime) with count \(array.count)")
    
    
    
    func append_one_in_place(_ a: inout [Int]) {
        a.append(1)
    }
    
    var inPlaceArray = [Int]()
    let appendInPlaceCopyTime = BNRTimeBlock {
        for _ in 0 ..< appendCount * 1000 {
            append_one_in_place(&inPlaceArray)
        }
    }
    
    print("append_one (in-place) time \(appendInPlaceCopyTime) with count \(inPlaceArray.count)")
}


// ------------------------------------------------------------

// MARK: - Protocol Polymorphism
🤓🤓 {
    struct Blorfle: DoesSomething {
        var a = 0, b = 0, c = 0
        func doOneThing() { }
        func doStuff() { print("Blorf") }
    }
    
    class GreebleVC: NSViewController, DoesSomething {
        var a = 0
        func doStuff() { print("Greeble") }
    }
    
    enum FlongWaffle: String, DoesSomething {
        case hello
        case there
        
        func doStuff() {
            print("waffle: \(self.rawValue)")
        }
    }
    
    let things: [DoesSomething] = [Blorfle(), GreebleVC(), FlongWaffle.hello]
    
    for thing in things {
        thing.doStuff()
    }
    
    func doStuff(with: DoesSomething) {

    }
    
    let blorfle = Blorfle()
    let greebleVC = GreebleVC()
    let flongWaffle = FlongWaffle.hello
    
    doStuff(with: blorfle)
    doStuff(with: greebleVC)
    doStuff(with: flongWaffle)
    
}


// ------------------------------------------------------------


// MARK: - Existential Containers and Protocol Types


let count = 10_000_000

// Protocol types for four classes, all conforming to `DoNothing`
var smallNothings = [DoNothing]()  // three words
var largeNothings = [DoNothing]()  // six words
var classNothings = [DoNothing]()  // six words, class type
var oneUseNothings = [DoNothing_OneUse]()  // six words, no other classes, hoping for devirtualization

// Arrays of the actual things
var smallThings = [SmallDoNothing]()
var largeThings = [LargeDoNothing]()
var classThings = [ClassDoNothing]()
var oneUseThings = [LargeDoNothing_OneUse]()


// MARK: Creation
//       (leave this turned on while doing other protocol type experiments)
🤓🤓 {
    let buildSmallNothingsTime = BNRTimeBlock {
        for _ in 0 ..< count {
            smallNothings.append(SmallDoNothing())
        }
    }
    
    let buildSmallThingsTime = BNRTimeBlock {
        for _ in 0 ..< count {
            smallThings.append(SmallDoNothing())
        }
    }
    
    print("time to create array of \(count) small doNothings: \(buildSmallNothingsTime) vs \(buildSmallThingsTime)")
    
    
    
    // -------------
    
    let buildLargeNothingsTime = BNRTimeBlock {
        for _ in 0 ..< count {
            largeNothings.append(LargeDoNothing())
        }
    }
    
    let buildLargeThingsTime = BNRTimeBlock {
        for _ in 0 ..< count {
            largeThings.append(LargeDoNothing())
        }
    }
    
    print("time to create array of \(count) large doNothings: \(buildLargeNothingsTime) vs \(buildLargeThingsTime)")
    
    
    
    // -------------
    
    let classNothingsTime = BNRTimeBlock {
        for _ in 0 ..< count {
            classNothings.append(ClassDoNothing())
        }
    }
    
    let buildClassNothingsTime = BNRTimeBlock {
        for _ in 0 ..< count {
            classThings.append(ClassDoNothing())
        }
    }
    
    print("time to create array of \(count) class doNothings: \(classNothingsTime) vs \(buildClassNothingsTime)")
    
    
    // -------------
    
    let oneUseLargeNothingsTime = BNRTimeBlock {
        for _ in 0 ..< count {
            oneUseNothings.append(LargeDoNothing_OneUse())
        }
    }
    
    let buildOneUseLargeNothingsTime = BNRTimeBlock {
        for _ in 0 ..< count {
            oneUseThings.append(LargeDoNothing_OneUse())
        }
    }
    
    print("time to create array of \(count) class one_use nothings: \(oneUseLargeNothingsTime) vs \(buildOneUseLargeNothingsTime)")
}


// MARK: Protocol Type Do-nothing map
🤓🤓 {
    if smallNothings.count == 0 {
        print("be sure to enable the 'Creation' code to set up the arrays")
        raise(11)
    }
    
    let smallMapNothingsTime = BNRTimeBlock {
        let _ = smallNothings.map { $0 }
    }
    
    let smallMapThingsTime = BNRTimeBlock {
        let _ = smallThings.map { $0 }
    }
    
    print("time to no-op map small doNothings: \(smallMapNothingsTime) vs \(smallMapThingsTime)")
    
    
    let largeMapNothingsTime = BNRTimeBlock {
        let _ = largeNothings.map { $0 }
    }
    
    let largeMapThingsTime = BNRTimeBlock {
        let _ = largeThings.map { $0 }
    }
    
    print("time to no-op map large doNothings: \(largeMapNothingsTime) vs \(largeMapThingsTime)")
    
    
    
    let classMapNothingsTime = BNRTimeBlock {
        let _ = classNothings.map { $0 }
    }
    
    let classMapThingsTime = BNRTimeBlock {
        let _ = classThings.map { $0 }
    }
    
    print("time to no-op map class doNothings: \(classMapNothingsTime) vs \(classMapThingsTime)")
    
    
    
    let oneUseMapNothingsTime = BNRTimeBlock {
        let _ = oneUseNothings.map { $0 }
    }
    
    let oneUseMapThingsTime = BNRTimeBlock {
        let _ = oneUseThings.map { $0 }
    }
    
    print("time to no-op map one-use doNothings: \(oneUseMapNothingsTime) vs \(oneUseMapThingsTime)")
}


// MARK: Protocol Type Call a function
🤓 {
    if smallNothings.count == 0 {
        print("be sure to enable the 'Creation' code to set up the arrays")
        raise(11)
    }

    let doStuffWithSmallNothingsTime = BNRTimeBlock {
        smallNothings.forEach { DoStuffWithNothing($0) }
    }
    
    let doStuffWithSmallThingsTime = BNRTimeBlock {
        smallThings.forEach { DoStuffWithNothing($0) }
    }
    
    print("call function small doNothings: \(doStuffWithSmallNothingsTime) vs \(doStuffWithSmallThingsTime)")
    
    
    let doStuffWithLargeNothingsTime = BNRTimeBlock {
        largeNothings.forEach { DoStuffWithNothing($0) }
    }
    
    let doStuffWithLargeThingsTime = BNRTimeBlock {
        largeThings.forEach { DoStuffWithNothing($0) }
    }
    
    print("call function large doNothings: \(doStuffWithLargeNothingsTime) vs \(doStuffWithLargeThingsTime)")
    
    
    let doStuffWithClassNothingsTime = BNRTimeBlock {
        classNothings.forEach { DoStuffWithNothing($0) }
    }
    
    let doStuffWithClassThingsTime = BNRTimeBlock {
        classThings.forEach { DoStuffWithNothing($0) }
    }
    
    print("call function class doNothings: \(doStuffWithClassNothingsTime) vs \(doStuffWithClassThingsTime)")
    
    
    let doStuffWithOneUseNothingsTime = BNRTimeBlock {
        oneUseNothings.forEach { DoStuffWithNothing($0) }
    }
    
    let doStuffWithOneUseThingsTime = BNRTimeBlock {
        oneUseThings.forEach { DoStuffWithNothing($0) }
    }
    
    print("call function oneUse doNothings: \(doStuffWithOneUseNothingsTime) vs \(doStuffWithOneUseThingsTime)")
}


// ------------------------------------------------------------


// MARK: - _final_ for Fun and Profit

let loopCount = 10_000_000

var nonFinalClass = NonFinalClass()  // nothing is final
var nonFinal_array = NonFinalClass_FinalArray()  // array property is final
var nonFinal_method = NonFinalClass_FinalMethod()  // doNothing function is final
var finalClass = FinalClass()  // class is final

// MARK: Method call
🤓🤓 {
    
    // Call a method that has final / non-final versions
    
    let nonFinalMethodCallTime = BNRTimeBlock {
        for _ in 0 ..< loopCount {
            nonFinalClass.doNothing()
            nonFinalClass.doNothing()
            nonFinalClass.doNothing()
            nonFinalClass.doNothing()
            nonFinalClass.doNothing()
            nonFinalClass.doNothing()
            nonFinalClass.doNothing()
            nonFinalClass.doNothing()
            nonFinalClass.doNothing()
            nonFinalClass.doNothing()
        }
    }
    
    print("non-final method call \(nonFinalMethodCallTime)")
    
    let nonFinalArrayMethodCallTime = BNRTimeBlock {
        for _ in 0 ..< loopCount {
            nonFinal_array.doNothing()
            nonFinal_array.doNothing()
            nonFinal_array.doNothing()
            nonFinal_array.doNothing()
            nonFinal_array.doNothing()
            nonFinal_array.doNothing()
            nonFinal_array.doNothing()
            nonFinal_array.doNothing()
            nonFinal_array.doNothing()
            nonFinal_array.doNothing()
        }
    }
    
    print("non-final, final array method call \(nonFinalArrayMethodCallTime)")
    
    
    let nonFinalMethodMethodCallTime = BNRTimeBlock {
        for _ in 0 ..< loopCount {
            nonFinal_method.doNothing()
            nonFinal_method.doNothing()
            nonFinal_method.doNothing()
            nonFinal_method.doNothing()
            nonFinal_method.doNothing()
            nonFinal_method.doNothing()
            nonFinal_method.doNothing()
            nonFinal_method.doNothing()
            nonFinal_method.doNothing()
            nonFinal_method.doNothing()
        }
    }
    
    print("non-final, final method method call \(nonFinalMethodMethodCallTime)")
    
    
    let finalClassMethodCallTime = BNRTimeBlock {
        for _ in 0 ..< loopCount {
            finalClass.doNothing()
            finalClass.doNothing()
            finalClass.doNothing()
            finalClass.doNothing()
            finalClass.doNothing()
            finalClass.doNothing()
            finalClass.doNothing()
            finalClass.doNothing()
            finalClass.doNothing()
            finalClass.doNothing()
        }
    }
    
    print("final class method call \(finalClassMethodCallTime)")
    
}

// MARK: Calling array property
🤓🤓 {
    let nonFinalArrayCallTime = BNRTimeBlock {
        for _ in 0 ..< loopCount {
            _ = nonFinalClass.array.count
            _ = nonFinalClass.array.count
            _ = nonFinalClass.array.count
            _ = nonFinalClass.array.count
            _ = nonFinalClass.array.count
            _ = nonFinalClass.array.count
            _ = nonFinalClass.array.count
            _ = nonFinalClass.array.count
            _ = nonFinalClass.array.count
            _ = nonFinalClass.array.count
        }
    }
    
    print("non-final array call \(nonFinalArrayCallTime)")
    
    let nonFinalArrayArrayCallTime = BNRTimeBlock {
        for _ in 0 ..< loopCount {
            _ = nonFinal_array.array.count
            _ = nonFinal_array.array.count
            _ = nonFinal_array.array.count
            _ = nonFinal_array.array.count
            _ = nonFinal_array.array.count
            _ = nonFinal_array.array.count
            _ = nonFinal_array.array.count
            _ = nonFinal_array.array.count
            _ = nonFinal_array.array.count
            _ = nonFinal_array.array.count
        }
    }
    
    print("non-final, final array array call \(nonFinalArrayArrayCallTime)")
    
    
    let nonFinalMethodArrayCallTime = BNRTimeBlock {
        for _ in 0 ..< loopCount {
            _ = nonFinal_method.array.count
            _ = nonFinal_method.array.count
            _ = nonFinal_method.array.count
            _ = nonFinal_method.array.count
            _ = nonFinal_method.array.count
            _ = nonFinal_method.array.count
            _ = nonFinal_method.array.count
            _ = nonFinal_method.array.count
            _ = nonFinal_method.array.count
            _ = nonFinal_method.array.count
        }
    }
    
    print("non-final, final method array call \(nonFinalMethodArrayCallTime)")
    
    
    let finalClassArrayCallTime = BNRTimeBlock {
        for _ in 0 ..< loopCount {
            _ = finalClass.array.count
            _ = finalClass.array.count
            _ = finalClass.array.count
            _ = finalClass.array.count
            _ = finalClass.array.count
            _ = finalClass.array.count
            _ = finalClass.array.count
            _ = finalClass.array.count
            _ = finalClass.array.count
            _ = finalClass.array.count
        }
    }
    
    print("final class array call \(finalClassArrayCallTime)")
    
}


// MARK: - Dave Mark's DeDuping
// Dave Mark had a qucik one-liner for deduping an array:
//   https://mobile.twitter.com/davemark/status/763124659940421632
//   dedupedArray = Array(Set(originalArray)).sorted()

🤓🤓 {
    // --------------------------
    
    func runIntDedup() {
        var dedupedArray: [Int]!
        
        let numbers = (0 ..< 1000000).map { $0 }
        let originalArray = numbers + numbers
        
        
        let intTime = BNRTimeBlock {
            dedupedArray = Array(Set(originalArray)).sorted()
        }
        
        print("\(intTime) to go from \(originalArray.count) -> \(dedupedArray.count) ints")
    }
    
    
    // --------------------------
    
    func runSmallThingDedup() {
        let smallThings = (0 ..< 1000000).map { return SmallThing($0, $0, $0) }
        let originalSmallThings = smallThings + smallThings
        
        var dedupedSmallThings: [SmallThing]!
        
        let smallThingTime = BNRTimeBlock {
            dedupedSmallThings = Array(Set(originalSmallThings)).sorted()
        }
        
        print("\(smallThingTime) to go from \(originalSmallThings.count) -> \(dedupedSmallThings.count) small things")
    }
    
    
    
    // --------------------------
    
    
    func runLargeThingDedup() {
        let largeThings = (0 ..< 1000000).map { return LargeThing($0, $0, $0, $0) }
        let originalLargeThings = largeThings + largeThings
        
        var dedupedLargeThings: [LargeThing]!
        
        let largeThingTime = BNRTimeBlock {
            dedupedLargeThings = Array(Set(originalLargeThings)).sorted()
        }
        
        print("\(largeThingTime) to go from \(originalLargeThings.count) -> \(dedupedLargeThings.count) large things")
    }
    
    
    
    // --------------------------
    
    
    func runReferenceThingDedup() {
        let referenceThings = (0 ..< 1000000).map { return ReferenceThing("\($0)") }
        let originalReferenceThings = referenceThings + referenceThings
        
        var dedupedReferenceThings: [ReferenceThing]!
        
        let referenceThingTime = BNRTimeBlock {
            dedupedReferenceThings = Array(Set(originalReferenceThings)).sorted()
        }
        
        print("\(referenceThingTime) to go from \(originalReferenceThings.count) -> \(dedupedReferenceThings.count) reference things")
    }
    
    
    // --------------------------
    
    
    func runCountingReferenceThingDedup() {
        CountingReferencer.clearRetainCounts()
        let countingReferenceThings = (0 ..< 1000000).map { return CountingReferenceThing(CountingReferencer(value: $0)) }
        let originalCountingReferenceThings = countingReferenceThings + countingReferenceThings
        
        var dedupedCountingReferenceThings: [CountingReferenceThing]!
        
        print("-done with setup \(CountingReferencer.numberOfRetains()) retains made-")
        CountingReferencer.clearRetainCounts()
        
        let countingReferenceThingTime = BNRTimeBlock {
            dedupedCountingReferenceThings = Array(Set(originalCountingReferenceThings)).sorted()
        }
        
        print("\(countingReferenceThingTime) to go from \(originalCountingReferenceThings.count) -> \(dedupedCountingReferenceThings.count) reference things with \(CountingReferencer.numberOfRetains()) retains")
    }
    
    func sanityCheckCountingReferenceThing() {
        let crt = CountingReferenceThing(CountingReferencer(value: 0))
        
        func printValue(_ thing: CountingReferenceThing) {
            //        print("\(crt)")
        }
        
        // got 14 in debug, 13 in release for `print("\(crt)")`.  heh
        // with no printing, got 1 in debug, 0 in release, presumably inlining
        CountingReferencer.clearRetainCounts()
        printValue(crt)
        print("\(CountingReferencer.numberOfRetains())")
    }
    
    
    runIntDedup()
    runSmallThingDedup()
    runLargeThingDedup()
    runReferenceThingDedup()
    runCountingReferenceThingDedup()

    // sanityCheckCountingReferenceThing()
}
