// Alert!  ARC is turned off for this file.

#import "CountingReferencer.h"

@interface CountingReferencer ()
@property (assign) NSInteger count;
@end // extension

static NSInteger g_retainCounts;



@implementation CountingReferencer

+ (NSInteger) numberOfRetains {
    return g_retainCounts;
} // numberOfRetains


+ (void) clearRetainCounts {
    g_retainCounts = 0;
} // clearRetainCounts


- (instancetype) initWithValue: (NSInteger) value {
    if ((self = [super init])) {
        _value = value;
    }
    return self;
} // initWithValue


- (NSUInteger) hash {
    return self.value;
} // hash


- (BOOL) isEqual: (CountingReferencer *) thing2 {
    return self.value == thing2.value;
} // isEqual


- (NSComparisonResult) compare: (CountingReferencer *) thing2 {
    if (self.value < thing2.value) return NSOrderedAscending;
    else if (self.value > thing2.value) return NSOrderedDescending;
    else return NSOrderedSame;
} // compare


- (instancetype) retain {
    g_retainCounts++;
    return [super retain];
} // retain


@end // CountingReferencer
