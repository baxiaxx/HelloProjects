//
//  MyManager.h
//  HelloFramework
//
//  Created by wesley_chen on 15/09/2017.
//  Copyright © 2017 wesley_chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyManager : NSObject

+ (void)hello;
- (instancetype)initWithName:(NSString *)name;
- (void)sayHello;

@end
