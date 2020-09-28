//
//  XURouterable.h
//  XURouter
//
//  Created by peng xu on 2020/9/28.
//

#import <UIKit/UIKit.h>
#import "XURouterCommand.h"
@class XURouterEndpoint;

typedef NS_ENUM(NSInteger, XUREndpointHandleResult) {
    XUREndpointHandleResultSucceed,
    XUREndpointHandleResultRedirect,
    XUREndpointHandleResultFailed,
};

typedef NS_ENUM(NSInteger, XURouteTransitionStyle) {
    XURouteTransitionPush,
    XURouteTransitionModal,
};

typedef void(^XURouterConditionCompletion)(BOOL match, NSString *message);
typedef void(^XURouterRedirectCompletion)(XURouterCommand *command);



#pragma mark -- XURouterEndPointProvider
@protocol XURouterEndPointProvider<NSObject>

@optional
+ (XURouterEndpoint *)endpointFor:(NSString *)domain path:(NSString *)path;

@end



#pragma mark -- XURouterableController
@protocol XURouterableController <NSObject, XURouterEndPointProvider>

@optional

- (instancetype)initWithRouteCommand:(XURouterCommand *)command;

/** 由Controller遵守，通过router传递的参数来初始化 */
- (instancetype)initWithRouterParameters:(NSDictionary *)parameters;

/** Parameters信息是否足够用来初始化 */
+ (BOOL)canHandleRouteParameters:(NSDictionary *)parameters;

/** 模态/Push，默认push */
+ (XURouteTransitionStyle)routeTransitionStyle;

/** 为模态present作准备，可以在这里添加导航控制器 */
+ (UIViewController *)routePrepareForModal:(UIViewController *)controller;

@end



#pragma mark -- XURouterCommand
@protocol XURouterCommand<NSObject>

/** 寻路的命令 */
- (XURouterCommand *)toRouteCommand;

@end



#pragma mark -- XURouterURLAdapter
@protocol XURouterURLAdapter<NSObject>

- (XURouterCommand *)adapt:(XURouterCommand *)command;

@end
