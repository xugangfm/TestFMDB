//
//  main.m
//  TestFMDB
//
//  Created by xugang on 8/10/14.
//  Copyright (c) 2014 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
//#define LOGTOFILE
int main(int argc, char * argv[])
{
#ifdef LOGTOFILE
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [paths objectAtIndex: 0];
    NSString *logPath = [documentDir stringByAppendingPathComponent:@"xsz.log"];
    NSLog(@"%@", logPath);
    freopen([logPath cStringUsingEncoding: NSASCIIStringEncoding], "a+", stdout);
    
    NSString *logPath2 = [documentDir stringByAppendingPathComponent:@"xsz2.log"];
    freopen([logPath2 cStringUsingEncoding: NSASCIIStringEncoding], "a+", stderr);
#endif
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
