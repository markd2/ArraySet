import Cocoa

func blah() {
    🤓🤓 {
        class Thing {
            var value = 10
            
        }
        
        let x = Thing()
        
        let y = x
        
        func useThing(thing: Thing) {
            print("Thing \(thing.value)")
        }
        
        
        struct UsesThing {
            let thing: Thing
        }
        
        var _ = UsesThing(thing: x)
        
        
        struct StructWithReferencer {
            let thing1: CountingReferencer = CountingReferencer()
        }
        
        let refStruct = StructWithReferencer()
        
        CountingReferencer.clearRetainCounts()
        
        let count = 10_000
        var refArray = [StructWithReferencer]()
        
        for _ in 0 ..< count {
            refArray.append(refStruct)
        }
        
        print("after adding \(count) items: \(CountingReferencer.numberOfRetains())")
    }
}




func blah2() {
    func doStuff(with: DoesSomething) {
    }
    
    
}






