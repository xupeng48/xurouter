//
//  XURouterEndpoint.m
//  XURouter
//
//  Created by peng xu on 2020/9/28.
//

#import "XURouterEndpoint.h"

@interface XURouterEndpoint()

@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong, readonly) Class <XURouterableController> targetClass;

@end

@implementation XURouterEndpoint

- (instancetype)initWithDomain:(NSString *)domain path:(NSString *)path class:(Class <XURouterableController>)cls {
    if (self = [super init]) {
        _domain = domain;
        _path = path;
        _targetClass = cls;
    }
    return self;
}

- (NSString *)uniqueKey {
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"xupeng";
    components.host = self.domain;
    components.path = self.path;
    return components.string;
}

- (void)processRouteCommand:(XURouterCommand *)command uuid:(NSString *)uuid navigationController:(UINavigationController *)navigationController {
    if (self.targetClass) {
        Class cls = self.targetClass;
        if ([cls respondsToSelector:@selector(canHandleRouteParameters:)]) {
            
        }
        UIViewController *controller;
        if ([cls instancesRespondToSelector:@selector(initWithRouteCommand:)]) {
            controller = [[cls alloc] initWithRouteCommand:command];
        } else if ([cls instancesRespondToSelector:@selector(initWithRouterParameters:)]) {
            controller = [[cls alloc] initWithRouterParameters:command.parameters];
        }
        if (controller) {
//            controller.
            UIViewController *topViewController = navigationController.visibleViewController;
            [topViewController presentViewController:controller animated:nil completion:nil];
        }
    }
}

@end
