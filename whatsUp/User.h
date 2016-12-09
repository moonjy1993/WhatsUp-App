//
//  User.h
//  whatsUp
//
//  Created by Ashley on 12/5/16.
//  Copyright © 2016 NYU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *email;
@property(strong, nonatomic) NSDictionary<NSString *, NSString *> *people;

-(instancetype)initWithName:(NSString *)name
                   andEmail:(NSString *)email;

@end
