//
//  AppDelegate.m
//  XURouter
//
//  Created by peng xu on 2020/9/28.
//

#import "AppDelegate.h"
#import "XURouterKit.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    
    [XU_Router loadAllEndpointsComplete:nil];
    return YES;
}

@end
