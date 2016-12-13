//
//  CheckIn.m
//  whatsUp
//
//  Created by sandy moon on 12/12/16.
//  Copyright © 2016 NYU. All rights reserved.
//

#import "CheckIn.h"

@implementation CheckIn

@synthesize coordinate, User, title, Image;


+(BOOL) initArray{
   CLLocationCoordinate2D co;
    co.latitude=40.7359;
    co.longitude= -73.9911;
    [CheckIn Add_Item:[CheckIn checkInfoWithUser:@"sandy" withtitle:@"dance show at union square!" withImage:@"cafeselfie.jpeg" withCoordinate: co]];
    CLLocationCoordinate2D co2;
    co2.latitude=40.7312;
    co2.longitude= -73.9971;
    [CheckIn Add_Item:[CheckIn checkInfoWithUser:@"jerry" withtitle:@"coffee break~" withImage:@"park.jpg" withCoordinate: co2]];
    CLLocationCoordinate2D co3;
    co3.latitude=40.733801;
    co3.longitude= -73.993147;
    [CheckIn Add_Item:[CheckIn checkInfoWithUser:@"brandon" withtitle:@"sat BRUNCH" withImage:@"brunch.jpeg" withCoordinate: co3]];
   
    
    
    return YES;
}
+(BOOL) CheckInitiated{
    if(!checkInArray){
        [CheckIn getArray];
    }
    return YES;
}

+(CheckIn*) checkInfoWithUser: (NSString *) User
                     withtitle: (NSString*) title
                    withImage: (NSString *) Image
                    withCoordinate:(CLLocationCoordinate2D)coordinate;
{
    CheckIn *Value= [[CheckIn alloc] initWithUser:User withtitle:title withImage:Image withCoordinate:coordinate];
    return Value;
}
-(CheckIn*) initWithUser:(NSString *)user withtitle:(NSString *)text withImage:(NSString *)image withCoordinate:(CLLocationCoordinate2D)Coordinate {
    self=[super init];
    
    if(self){
        self.User= user;
        self.title=text;
        self.Image= image;
        self.coordinate= Coordinate;
    }
    return self;
}
+(NSMutableArray*) getArray;
{
    if(!checkInArray){
        checkInArray=[[NSMutableArray alloc] init];
        [CheckIn initArray];
    }
    return checkInArray ;
}


//setteer and getter

-(CLLocationCoordinate2D) getcoordinate{
    return coordinate;
}
+(int) size;{
    return [[CheckIn getArray] count];
}

+(BOOL) Add_Item:(CheckIn *) value;
{
    NSMutableArray *_checkInArray;
    _checkInArray= [CheckIn getArray];
    [_checkInArray addObject:value];
    
    return YES;
    
}
@end
