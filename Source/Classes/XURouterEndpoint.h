//
//  XURouterEndpoint.h
//  XURouter
//
//  Created by peng xu on 2020/9/28.
//

#import <Foundation/Foundation.h>
#import "XURouterable.h"

@interface XURouterEndpoint : NSObject

/** 根据scheme,domain,path生成的唯一的key */
@property (nonatomic, readonly) NSString *uniqueKey;

- (instancetype)initWithDomain:(NSString *)domain
                          path:(NSString *)path
                         class:(Class <XURouterableController>)cls;

- (void)processRouteCommand:(XURouterCommand *)command
                       uuid:(NSString *)uuid
       navigationController:(UINavigationController *)navigationController;

@end
