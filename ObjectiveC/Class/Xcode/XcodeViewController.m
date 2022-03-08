//
//  XcodeViewController.m
//  ObjectiveC
//
//  Created by zhangchunpeng1 on 2022/2/18.
//  Copyright © 2022 张春鹏. All rights reserved.
//

#import "XcodeViewController.h"


#include <assert.h>
#include <stdbool.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/sysctl.h>

static bool AmIBeingDebugged(void) {

    // Returns true if the current process is being debugged (either
    // running under the debugger or has a debugger attached post facto).

    int                 junk;
    int                 mib[4];
    struct kinfo_proc   info;
    size_t              size;

    // Initialize the flags so that, if sysctl fails for some bizarre
    // reason, we get a predictable result.

    info.kp_proc.p_flag = 0;

    // Initialize mib, which tells sysctl the info we want, in this case
    // we're looking for information about a specific process ID.
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_PROC;
    mib[2] = KERN_PROC_PID;
    mib[3] = getpid();
    
    size = sizeof(info);
    junk = sysctl(mib, sizeof(mib) / sizeof(*mib), &info, &size, NULL, 0);
    assert(junk == 0);
    
    // We're being debugged if the P_TRACED flag is set.

    return ( (info.kp_proc.p_flag & P_TRACED) != 0 );
}



//#import <asl.h>
//#include <os/log.h>
//#include <syslog.h>


@interface XcodeViewController ()

@end

@implementation XcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"11111111 %d", AmIBeingDebugged());
    
    
//    syslog(0, "%s", @"222222222".UTF8String);
    
    
//    const char *msg = [@"2222222222222" UTF8String];
//
//
//    // NSLog uses the current euid to set the ASL_KEY_READ_UID.
////    uid_t const readUID = geteuid();
//
//    char readUIDString[16];
//#ifndef NS_BLOCK_ASSERTIONS
////    size_t l = (size_t)snprintf(readUIDString, sizeof(readUIDString), "%d", readUID);
//#else
//    snprintf(readUIDString, sizeof(readUIDString), "%d", readUID);
//#endif
//
//    aslclient _client = asl_open(NULL, "com.apple.console", 0);
//
//    aslmsg m = asl_new(ASL_TYPE_MSG);
//    if (m != NULL) {
//        if (asl_set(m, ASL_KEY_LEVEL, "123") == 0 &&
//            asl_set(m, ASL_KEY_MSG, msg) == 0 &&
//            asl_set(m, ASL_KEY_READ_UID, readUIDString) == 0 &&
//            asl_set(m, "zhcpeng", "12345") == 0) {
//            asl_send(_client, m);
//        }
//        asl_free(m);
//    }
}


@end
