#import "employee.h"

@implementation Employee

- (double) yrsofemp{
	NSDate *date = _hiredate;

	if(date){
		NSDate * now = [NSDate date];
		NSTimeInterval secs = [now timeIntervalSinceDate:date];
		return secs/31557600;
	}else{
		return 0;
	}

}

- (float) getBMI{
	float a = [super getBMI];
	return a + 10;
}

@end