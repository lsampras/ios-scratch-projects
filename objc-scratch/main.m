#import <Foundation/Foundation.h>
#import "employee.h"
int main(void){
    @autoreleasepool {
    
        float suf = 3.33;
        NSLog(@"Hello World %f", suf);
        // 
        Employee * sam = [[Employee alloc] init];
//         
        // [sam setheight:2.3];
        // [sam setwidth:23];

        sam._width = 3;
        sam._height = 1;

//         
        // float h = [sam heightinm];
        // int w = [sam widthinm];
        sam.hiredate = [NSDate dateWithNaturalLanguageString:@"jan 2nd, 2019"];
//         
        NSLog(@"BMI: %f", [sam getBMI]);
        NSLog(@"EMP: %f", [sam yrsofemp]);
    }
    return 0;
}
