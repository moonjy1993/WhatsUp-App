//
//  User.m
//  whatsUp
//
//  Created by Ashley on 12/5/16.
//  Copyright © 2016 NYU. All rights reserved.
//

#import "User.h"

@implementation User

//This is the user class. Stores the name and email property for each user. 

-(instancetype)initWithName:(NSString *)name
                   andEmail:(NSString *)email
                 andFriends:(NSMutableArray *) friends{
    self = [super init];
    if(self){
        self.name = name;
        self.email = email;
        self.friends = friends;
    }
    return self;
}


@end
