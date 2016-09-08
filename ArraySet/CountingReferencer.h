#import <Foundation/Foundation.h>


@interface CountingReferencer : NSObject

+ (NSInteger) numberOfRetains;
+ (void) clearRetainCounts;

@property (readonly) NSInteger value;

- (instancetype) initWithValue: (NSInteger) value;


@end // CountingReferencer

