//
//  XURouter.m
//  XURouter
//
//  Created by peng xu on 2020/9/28.
//

#import "XURouter.h"
#import <mach-o/dyld.h>
#import <mach-o/getsect.h>

#ifndef __LP64__
#define section_ section
#define mach_header_ mach_header
#else
#define section_ section_64
#define mach_header_ mach_header_64
#endif

@interface XURouter()

@property (nonatomic, strong) UINavigationController *defaultNavigationController;

@property (nonatomic, strong) NSMutableDictionary <NSString *, XURouterEndpoint *> *routingTable;

@end

@implementation XURouter

- (instancetype)init {
    if (self = [super init]) {
        _routingTable = [NSMutableDictionary new];
    }
    return self;
}

- (void)setDefaultNavigacontroller:(UINavigationController *)navigationController {
    _defaultNavigationController = navigationController;
}

- (void)loadAllEndpointsComplete:(dispatch_block_t)completion {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *endPoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"XURouter" ofType:@"plist"]];
        for (NSDictionary *endPoint in endPoints) {
            NSString *qtr_domain = endPoint[@"xur_domain"];
            NSString *path = endPoint[@"xur_path"];
            NSString *className = [[NSString alloc] initWithString:endPoint[@"xur_class"]];
            Class <XURouterEndPointProvider> provider = NSClassFromString(className);
            if ([provider respondsToSelector:@selector(endpointFor:path:)]) {
                XURouterEndpoint *endpoint = [provider endpointFor:qtr_domain path:path];
                [self registerEndpoint:endpoint];
            }
        }
    });
}

- (void)registerEndpoint:(XURouterEndpoint *)endpoint {
    if (endpoint.uniqueKey) {
        [self.routingTable setObject:endpoint forKey:endpoint.uniqueKey];
    }
}

- (void)route:(id <XURouterCommand>)command {
    UINavigationController *controller = [self navigationController];
    [self route:command byNavigationControler:controller complete:nil];
}

- (void)route:(id <XURouterCommand>)command byNavigationControler:(UINavigationController *)navigationController complete:(void(^)(BOOL, NSError *))complete {
//    XURouteCommand *routeCommand = command.toRouteCommand.copy;
    [self _route:command uuid:nil depth:1 byNav:navigationController complete:nil];
}

- (void)_route:(XURouterCommand *)command uuid:(NSString *)uuid depth:(NSInteger)depth byNav:(UINavigationController *)navigationController complete:(void (^)(BOOL, NSError *))complete {
    XURouterEndpoint *endpoint = [self endpointFromCommand:command];
    [endpoint processRouteCommand:command
                             uuid:nil
             navigationController:navigationController];
}

- (XURouterEndpoint *)endpointFromCommand:(XURouterCommand *)command {
    if (!command.uniqueKey) {
        return nil;
    }
    XURouterEndpoint *endpoint = [self.routingTable objectForKey:command.uniqueKey];
//    if (endpoint) {
        return endpoint;
//    }
//    if (self.) {
//        <#statements#>
//    }
}



// MARK: -- navigationController
- (UINavigationController *)navigationController {
    UIViewController *topController = [self _findTopViewController];
    if (topController.navigationController) {
        return topController.navigationController;
    }
    return self.defaultNavigationController;
}

- (UIViewController *)_findTopViewController {
    UIViewController *topViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    while (true) {
//        if ([topViewController conformsToProtocol:@protocol(XURouterContainerController)]) {
//            topViewController = [(id<XURouterContainerController>)topViewController routerVisiableController];
//        } else
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)topViewController;
            topViewController = nav.topViewController;
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}

@end
