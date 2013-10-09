//
// Card .m
//
#import "Card.h"

@implementation Card
@synthesize value ;
@synthesize suit = _suit;

- ( NSString *) suit {
    return _suit ;
}

- (void) setSuit :( NSString *)s {
    _suit = s;
}
@end
