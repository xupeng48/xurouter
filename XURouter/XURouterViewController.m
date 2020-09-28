//
//  XURouterViewController.m
//  XURouter
//
//  Created by peng xu on 2020/9/28.
//

#import "XURouterViewController.h"
#import "XURouterKit.h"

//XUR_Endpoint_Register_Controller_NO_Paramters(@"XURouter",
//                                              @"/app/test/route",
//                                              @"XURouterViewController",
//                                              app_test_route);
//
//



@interface XURouterViewController ()

@end

@implementation XURouterViewController

XUR_Endpoint_Register_Controller_NO_Paramters(@"XURouter",
                                              @"/app/test/route",
                                              @"XURouterViewController",
                                              app_test_route)

//+ (XURouterEndpoint *)endpointFor:(NSString *)domain path:(NSString *)path {
//    return [[XURouterEndpoint alloc] initWithDomain:domain path:path class:[self class]];
//}

//- (instancetype)initWithRouterParameters:(NSDictionary *)parameters {
//    return [self init];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"success");
}

@end
