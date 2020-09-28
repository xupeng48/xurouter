//
//  XURouter.h
//  XURouter
//
//  Created by peng xu on 2020/9/28.
//

#import <Foundation/Foundation.h>
#import "XURouterable.h"
#import "XURouterMacro.h"
#import "XURouterEndpoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface XURouter : NSObject

- (void)setDefaultNavigacontroller:(UINavigationController *)navigationController;

/** 装在所有的Endpoint */
- (void)loadAllEndpointsComplete:(dispatch_block_t)completion;

/** 寻路 */
- (void)route:(id <XURouterCommand>)command;

@end

NS_ASSUME_NONNULL_END
