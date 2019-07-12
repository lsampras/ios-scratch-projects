#import "Person.h"

@implementation Person


// - (float)heightinm
// {
//     return _height;
// }
// - (void)setheight:(float)h
// {
//     _height = h;
// }
// - (int)widthinm{
//     return _width;
// }
// - (void)setwidth:(int)w
// {
//     _width = w +1;
// }


- (float)getBMI
{
	float _height = __height;
    return __width/(_height*_height);
}


@end