//
//  FlexInject.m
//  FlexInject
//
//  Created by 罗红瑞 on 2017/2/16.
//  Copyright (c) 2017年 __MyCompanyName__. All rights reserved.
//

#import "CaptainHook.h"
#import "FLEXManager.h"

CHDeclareClass(UIViewController);

// 参数个数，返回值类型，类的名称，selector 的名称，selector 的类型，selector 对应的参数的变量名。

CHMethod(2, void, UIViewController, motionEnded, UIEventSubtype, motion, withEvent, UIEvent *, event)
{
    NSLog(@"CaptainHook HOOK motionEnded");
    
    [[FLEXManager sharedManager] showExplorer];
    
    return CHSuper2(UIViewController, motionEnded, motion, withEvent, event);
}


CHDeclareClass(NMSong);

// 参数个数，返回值类型，类的名称，selector 的名称，selector 的类型，selector 对应的参数的变量名。

CHMethod(0, BOOL, NMSong, canDownloadMusic)
{
    NSLog(@"CaptainHook HOOK HOOK canDownloadMusic");
    return YES;
}

CHMethod(0, id, NMSong, playUrlInfo)
{
    NSLog(@"CaptainHook HOOK playUrlInfo");
    return CHSuper(0, NMSong, playUrlInfo);
}

CHMethod(0, id, NMSong, downloadUrlInfo)
{
    NSLog(@"CaptainHook HOOK downloadUrlInfo");
    return CHSuper(0, NMSong, playUrlInfo);
}


__attribute__((constructor)) static void entry()
{
    CHLoadLateClass(UIViewController);
    CHHook2(UIViewController, motionEnded, withEvent);
    
    
    CHLoadLateClass(NMSong);
    CHClassHook(0, NMSong, canDownloadMusic);
    CHClassHook(0, NMSong, playUrlInfo);
    CHClassHook(0, NMSong, downloadUrlInfo);
}

