//
// Card .h
//

# import <Foundation/Foundation.h>

@interface Card : NSObject
{
    NSString * _suit;
    int value ;
}
@property (nonatomic,retain) NSString * suit;

@property int value ; // declares that the accessors to value should be created automatically - ( NSString *) suit ;
- ( void ) setSuit : ( NSString *) s;
@end
