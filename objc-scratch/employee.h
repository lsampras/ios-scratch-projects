#import "Person.h"

@interface Employee : Person

@property (nonatomic) unsigned int EmployeeID;
@property (nonatomic) int AlarmCode;
@property (nonatomic) NSDate * hiredate;

- (double)yrsofemp;



@end