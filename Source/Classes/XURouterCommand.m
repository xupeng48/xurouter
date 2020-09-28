//
//  XURouterCommand.m
//  XURouter
//
//  Created by peng xu on 2020/9/28.
//

#import "XURouterCommand.h"

@implementation XURouterCommand

- (instancetype)initWithScheme:(NSString *)scheme
                        domain:(NSString *)domain
                          path:(NSString *)path
                    parameters:(NSDictionary<NSString *, NSString *> *)parameters {
    if (self = [super init]) {
        _scheme = scheme;
        _domain = domain;
        _path = path;
        _parameters = parameters;
    }
    return self;
}

+ (instancetype)commandWithDomain:(NSString *)domain
                             path:(NSString *)path
                       parameters:(NSDictionary<NSString *, NSString *> *)parameters {
    return [[XURouterCommand alloc] initWithScheme:@"xupeng" domain:domain path:path parameters:parameters];
}

- (NSString *)uniqueKey {
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = self.scheme;
    components.host = self.domain;
    components.path = self.path;
    return components.string;
}

@end
