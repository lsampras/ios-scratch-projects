#import <Foundation/Foundation.h>


@interface Person : NSObject


@property (nonatomic) float _height;
@property (nonatomic) int _width;

// {
//     float _height;
//     int _width;
// }

// - (float)heightinm;
// - (void)setheight:(float)h;
// - (int)widthinm;
// - (void)setwidth:(int)w;


- (float)getBMI;


@end
