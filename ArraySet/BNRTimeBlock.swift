import Foundation

import Darwin

func BNRTimeBlock(_ block: () -> Void) -> TimeInterval {
    var info = mach_timebase_info()
    guard mach_timebase_info(&info) == KERN_SUCCESS else { return -1 }
    
    let start = mach_absolute_time()
    block()
    let end = mach_absolute_time()
    
    let elapsed = end - start
    
    let nanos = elapsed * UInt64(info.numer) / UInt64(info.denom)
    return TimeInterval(nanos) / TimeInterval(NSEC_PER_SEC)
}

