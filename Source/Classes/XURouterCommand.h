//
//  XURouterCommand.h
//  XURouter
//
//  Created by peng xu on 2020/9/28.
//

#import <Foundation/Foundation.h>

@interface XURouterCommand : NSObject

@property (nonatomic, readonly) NSString *scheme;           /**< 对应URL的scheme */
@property (nonatomic, readonly) NSString *domain;           /**< 对应URL的domain，建议用domain对功能进行区分 */
@property (nonatomic, readonly) NSString *path;             /**< 对应URL的path，不要在路由里存储参数 */
@property (nonatomic, readonly) NSString *originalString;   /**< 如果是根据字符串初始化的，这里可以获取到最原始的字符串 */
@property (nonatomic, readonly) NSString *uniqueKey;        /**< 唯一标示 */
@property (nonatomic, readonly) NSDictionary <NSString *, NSString *> *parameters;


+ (instancetype)commandWithDomain:(NSString *)domain
                             path:(NSString *)path
                       parameters:(NSDictionary<NSString *,NSString *> *)parameters;

@end

