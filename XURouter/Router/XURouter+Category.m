//
//  XURouter+Category.m
//  XURouter
//
//  Created by peng xu on 2020/9/28.
//

#import "XURouter+Category.h"

@implementation XURouter (Category)

+ (instancetype)shared {
    static XURouter *_router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _router = [XURouter new];
    });
    return _router;
}

@end
