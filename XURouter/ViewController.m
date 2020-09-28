//
//  ViewController.m
//  XURouter
//
//  Created by peng xu on 2020/9/28.
//

#import "ViewController.h"
#import "XURouterKit.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    XURouterCommand *command = [XURouterCommand commandWithDomain:@"XURouter"
                                                             path:@"/app/test/route"
                                                       parameters:nil];
    [XU_Router route:command];
}

@end
