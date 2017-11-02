//
//  AppDelegate.m
//  AppTest
//
//  Created by wesley_chen on 25/10/2017.
//  Copyright © 2017 wesley_chen. All rights reserved.
//

#import "AppDelegate.h"

@import HelloModularFramework_Submodule;
@import HelloModularFramework_Submodule.PublicClassB;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [PublicClassA doSomething];
    [PublicClassB doSomething];
    [PublicClassD doSomething];
    
    return YES;
}

@end