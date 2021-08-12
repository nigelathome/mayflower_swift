###常用lldb命令
1.读寄存器的值

```
register read
register read x0
po 0x0000000102615468
```
寄存器x0-x7存储程序参数

2.对象打印

```
x obj //以16进制打印对象的内存 iOS小端模式 
memory read obj //作用同x

(lldb) x obj
0x100629400: a5 83 00 00 01 80 1d 01 18 40 00 00 01 00 00 00  .........@......
0x100629410: 38 40 00 00 01 00 00 00 00 00 00 00 00 80 66 40  8@............f@
(lldb) po 0x100629400
<LGTeacher: 0x100629400>

x/6gx //输出8个16进制的地址空间

(lldb) x/6gx obj
0x100627d30: 0x011d8001000083ad 0x0000000100004020
0x100627d40: 0x0000000100004040 0x00000000000000b4
0x100627d50: 0x0000000000000012 0x0000000000000000

Debug -> Debug Workflow -> View Memory //查看所有内存
```

3.类所占的空间大小

```
sizeof(NSInteger)
sizeof(p)
```

4.p/po  
p打印对象的全部信息，po调用对象的description方法，description方法可以通过重写定制输出格式

```
(lldb) po t
<LGTeacher: 0x10140b600>

(lldb) p t
(LGTeacher *) $3 = 0x000000010140b600
```

5.clang  
clang是Apple基于LLVM的编译器前端，可以用于c/cpp/objective-c的编译  

```
clang -rewrite-objc main.m -o main.cpp //将main.m 编译成main.cpp
```
 
6.bt 
打印当前线程的调用堆栈，断点模式下的cmd+7可以查看所有线程的调用堆栈
 
```
(lldb) bt
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
  * frame #0: 0x0000000108902213 iOSAppDev`-[ViewController viewDidLoad](self=0x00007f924ec12ef0, _cmd="viewDidLoad") at ViewController.m:33:5
    frame #1: 0x000000010c2558ed UIKitCore`-[UIViewController _sendViewDidLoadWithAppearanceProxyObjectTaggingEnabled] + 88
    frame #2: 0x000000010c25a273 UIKitCore`-[UIViewController loadViewIfRequired] + 1084
    frame #3: 0x000000010c25a65d UIKitCore`-[UIViewController view] + 27
    frame #4: 0x00000001089033f5 iOSAppDev`-[AppDelegate application:didFinishLaunchingWithOptions:](self=0x0000600002d99e20, _cmd="application:didFinishLaunchingWithOptions:", application=0x00007f924ed05520, launchOptions=0x0000000000000000) at AppDelegate.m:23:9
    frame #5: 0x000000010c98a46d UIKitCore`-[UIApplication _handleDelegateCallbacksWithOptions:isSuspended:restoreState:] + 232
    frame #6: 0x000000010c98bfef UIKitCore`-[UIApplication _callInitializationDelegatesWithActions:forCanvas:payload:fromOriginatingProcess:] + 3919
    frame #7: 0x000000010c9919fd UIKitCore`-[UIApplication _runWithMainScene:transitionContext:completion:] + 1237
    frame #8: 0x000000010bfbc7bb UIKitCore`-[_UISceneLifecycleMultiplexer completeApplicationLaunchWithFBSScene:transitionContext:] + 122
    frame #9: 0x000000010c54a20a UIKitCore`_UIScenePerformActionsWithLifecycleActionMask + 88
    frame #10: 0x000000010bfbd2ca UIKitCore`__101-[_UISceneLifecycleMultiplexer _evalTransitionToSettings:fromSettings:forceExit:withTransitionStore:]_block_invoke + 198
    frame #11: 0x000000010bfbcd8e UIKitCore`-[_UISceneLifecycleMultiplexer _performBlock:withApplicationOfDeactivationReasons:fromReasons:] + 474
    frame #12: 0x000000010bfbd0fb UIKitCore`-[_UISceneLifecycleMultiplexer _evalTransitionToSettings:fromSettings:forceExit:withTransitionStore:] + 819
    frame #13: 0x000000010bfbc98f UIKitCore`-[_UISceneLifecycleMultiplexer uiScene:transitionedFromState:withTransitionContext:] + 345
    frame #14: 0x000000010bfc4c27 UIKitCore`__186-[_UIWindowSceneFBSSceneTransitionContextDrivenLifecycleSettingsDiffAction _performActionsForUIScene:withUpdatedFBSScene:settingsDiff:fromSettings:transitionContext:lifecycleActionType:]_block_invoke + 178
    frame #15: 0x000000010c453fe7 UIKitCore`+[BSAnimationSettings(UIKit) tryAnimatingWithSettings:actions:completion:] + 871
    frame #16: 0x000000010c566ab2 UIKitCore`_UISceneSettingsDiffActionPerformChangesWithTransitionContext + 240
    frame #17: 0x000000010bfc492d UIKitCore`-[_UIWindowSceneFBSSceneTransitionContextDrivenLifecycleSettingsDiffAction _performActionsForUIScene:withUpdatedFBSScene:settingsDiff:fromSettings:transitionContext:lifecycleActionType:] + 361
    frame #18: 0x000000010bde8034 UIKitCore`__64-[UIScene scene:didUpdateWithDiff:transitionContext:completion:]_block_invoke + 797
    frame #19: 0x000000010bde6ade UIKitCore`-[UIScene _emitSceneSettingsUpdateResponseForCompletion:afterSceneUpdateWork:] + 253
    frame #20: 0x000000010bde7c6d UIKitCore`-[UIScene scene:didUpdateWithDiff:transitionContext:completion:] + 208
    frame #21: 0x000000010c98fe9c UIKitCore`-[UIApplication workspace:didCreateScene:withTransitionContext:completion:] + 508
    frame #22: 0x000000010c47c3f3 UIKitCore`-[UIApplicationSceneClientAgent scene:didInitializeWithEvent:completion:] + 358
    frame #23: 0x0000000114c8c0ae FrontBoardServices`-[FBSScene _callOutQueue_agent_didCreateWithTransitionContext:completion:] + 391
    frame #24: 0x0000000114cb4b41 FrontBoardServices`__94-[FBSWorkspaceScenesClient createWithSceneID:groupID:parameters:transitionContext:completion:]_block_invoke.176 + 102
    frame #25: 0x0000000114c99ad5 FrontBoardServices`-[FBSWorkspace _calloutQueue_executeCalloutFromSource:withBlock:] + 209
    frame #26: 0x0000000114cb480f FrontBoardServices`__94-[FBSWorkspaceScenesClient createWithSceneID:groupID:parameters:transitionContext:completion:]_block_invoke + 352
    frame #27: 0x000000010a7d49c8 libdispatch.dylib`_dispatch_client_callout + 8
    frame #28: 0x000000010a7d7910 libdispatch.dylib`_dispatch_block_invoke_direct + 295
    frame #29: 0x0000000114cda7a5 FrontBoardServices`__FBSSERIALQUEUE_IS_CALLING_OUT_TO_A_BLOCK__ + 30
    frame #30: 0x0000000114cda48b FrontBoardServices`-[FBSSerialQueue _targetQueue_performNextIfPossible] + 433
    frame #31: 0x0000000114cda950 FrontBoardServices`-[FBSSerialQueue _performNextFromRunLoopSource] + 22
    frame #32: 0x00000001091f137a CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 17
    frame #33: 0x00000001091f1272 CoreFoundation`__CFRunLoopDoSource0 + 180
    frame #34: 0x00000001091f0754 CoreFoundation`__CFRunLoopDoSources0 + 248
    frame #35: 0x00000001091eaf1f CoreFoundation`__CFRunLoopRun + 878
    frame #36: 0x00000001091ea6c6 CoreFoundation`CFRunLoopRunSpecific + 567
    frame #37: 0x0000000114fdadb3 GraphicsServices`GSEventRunModal + 139
    frame #38: 0x000000010c98e187 UIKitCore`-[UIApplication _run] + 912
    frame #39: 0x000000010c993038 UIKitCore`UIApplicationMain + 101
    frame #40: 0x0000000108903eb2 iOSAppDev`main(argc=1, argv=0x00007ffee7300038) at main.m:17:12
    frame #41: 0x000000010a863409 libdyld.dylib`start + 1
    frame #42: 0x000000010a863409 libdyld.dylib`start + 1
(lldb) 
```

7.image list
查看内存镜像文件。可以查看到加入内存的动态库，并通过路径+‘go to folder’可以找到在该动态库

```
(lldb) image list
[  0] F83AA97B-16F9-3A31-9264-6AAB049F483C 0x000000010075e000 /Users/lihui40/Library/Developer/Xcode/DerivedData/iOSAppDev-csklnipqugtmmubggpfkhzyabanr/Build/Products/Debug-iphonesimulator/iOSAppDev.app/iOSAppDev 
[  1] 1AC76561-4F9A-34B1-BA7C-4516CACEAED7 0x000000011021a000 /usr/lib/dyld 
[  2] CD67BB61-ACDC-3CB4-A895-060302DDCF77 0x0000000100776000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/dyld_sim 
[  3] 16ECBE10-D485-35C2-B9F2-DF9DC8B17D1E 0x00000001009d2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Foundation.framework/Foundation 
[  4] 3B8BB6ED-2816-33B4-AC07-938D1BC458A1 0x0000000100f6d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libobjc.A.dylib 
[  5] 56496093-74A5-386D-AB0D-CF3989CFC246 0x0000000100fc6000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libSystem.B.dylib 
[  6] 0A5546C3-A9A9-3559-A6F8-A399CF91A1DE 0x0000000100fd1000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation 
[  7] 246D7C9E-4D5E-3D3D-850F-5A713EF6444D 0x0000000101788000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/UIKit.framework/UIKit 
[  8] D18C3188-08A9-326C-9C57-6913A28B0CD2 0x000000010178f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreAutoLayout.framework/CoreAutoLayout 
[  9] 717B7EEF-9429-324D-B083-89005CEF3534 0x000000010181a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libcompression.dylib 
[ 10] 6CCBADD2-25C4-3FD3-9CA5-2D5AE308C5F7 0x000000010183d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CFNetwork.framework/CFNetwork 
[ 11] E70B1AAE-8B79-3044-B51D-6B37DEB9D3B1 0x0000000101ded000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libarchive.2.dylib 
[ 12] 316361F6-63B9-36CA-AA94-469F29B4F49E 0x0000000101e79000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libicucore.A.dylib 
[ 13] AEAB96ED-C638-3F3D-93E8-EEC7DBD63489 0x00000001021de000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libxml2.2.dylib 
[ 14] 0D3637F3-FD33-332D-A8E7-EF8FBE38D85C 0x0000000102306000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/liblangid.dylib 
[ 15] 01835142-F743-343C-B974-957086C444F2 0x0000000102310000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/IOKit.framework/Versions/A/IOKit 
[ 16] F32A4633-538E-3B36-82E0-B3DAAEAEA304 0x00000001023ec000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libCRFSuite.dylib 
[ 17] 595F454E-40EB-3E69-A9B0-C9B55B79D3DD 0x0000000102436000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SoftLinking.framework/SoftLinking 
[ 18] 62139B53-1757-3939-AF86-9A64E3BA608F 0x000000010243e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libc++abi.dylib 
[ 19] 0BB614C9-CE8F-3BF7-B6E5-C29920CF6AD3 0x0000000102471000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libc++.1.dylib 
[ 20] 07EA6AA1-58A7-3D1D-A43C-1F9114DABD0D 0x000000010251c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libcache.dylib 
[ 21] 59157B86-C073-374A-B213-7E3F71C531E3 0x0000000102529000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libcommonCrypto.dylib 
[ 22] E80E864B-7DF2-32BD-86DB-C96E193D1F0C 0x0000000102548000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libcompiler_rt.dylib 
[ 23] 8EE17C80-E264-3363-B141-BCF6B89679C7 0x000000010255c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libcopyfile.dylib 
[ 24] 32F2A5CF-2FAC-3AF1-BC39-41E20B0205C5 0x0000000102570000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libcorecrypto.dylib 
[ 25] 9B5BCF4C-87B2-3E76-A722-E09DD6C9FDD0 0x0000000102631000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/introspection/libdispatch.dylib 
[ 26] 5E7C90FB-DD12-3748-87E1-9F91C2D5A70F 0x00000001026c2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libdyld.dylib 
[ 27] DD0F3E22-C953-31FD-8011-6D251FAAA05A 0x0000000102726000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/liblaunch.dylib 
[ 28] AE5114C9-02FE-3A4F-BDDE-507C85195FEF 0x000000010272f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libmacho.dylib 
[ 29] 2F59D524-A4D8-39ED-BB88-CEF1321DC7CA 0x000000010273e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libremovefile.dylib 
[ 30] 1E0EE86E-C056-3F7C-B7E5-FF70050F240D 0x0000000102748000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_asl.dylib 
[ 31] 92E02106-AB52-3C0A-90E2-9AA5F35FD8F3 0x0000000102770000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_blocks.dylib 
[ 32] 555E5E98-1EB5-33B9-BA34-2AFCB06A9C21 0x000000010277c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_c.dylib 
[ 33] 6FA21215-5CE1-3AEB-ABF6-CF3C3518BE2B 0x000000010282e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_collections.dylib 
[ 34] 9F02F335-5D46-3FDA-B79F-75CFEB27BB57 0x000000010283b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_configuration.dylib 
[ 35] 68E1E451-973F-32AB-A809-62ABAABA3C9D 0x0000000102848000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_containermanager.dylib 
[ 36] 51D84290-D1AB-3E12-A594-8317A1C2810D 0x0000000102869000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_coreservices.dylib 
[ 37] D82E5BEA-45C1-34FC-8C7E-083B24A9F77B 0x0000000102873000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_darwin.dylib 
[ 38] 95249F79-87E2-3A87-94F8-9D25C9D4A005 0x000000010288b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_dnssd.dylib 
[ 39] B94572B5-71DB-30A7-A0E7-949B919EB231 0x000000010289d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_featureflags.dylib 
[ 40] AB7D99DF-4868-37EA-AD2A-B1F352B37A66 0x00000001028a8000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_info.dylib 
[ 41] B43DA127-83BC-3E98-A0D7-5633AF9724CB 0x00000001028e5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_m.dylib 
[ 42] 5F513433-D707-31FD-8E77-4A5BC1759363 0x0000000102939000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_malloc.dylib 
[ 43] C11E632E-E533-3E76-B47C-6BCAF73E9D2F 0x000000010297f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_notify.dylib 
[ 44] 7824995B-DEA2-3A1C-976A-EBAD32F351FA 0x0000000102995000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_product_info_filter.dylib 
[ 45] F9B8BAB0-0B7E-39BE-8594-6DC7FE72C474 0x000000010299b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_sandbox.dylib 
[ 46] 7D3FC7C5-A6B1-3AAF-ADB7-363B79A94EFD 0x00000001029a9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_sim_kernel.dylib 
[ 47] 25179979-EA74-3418-A01E-818F0D2A9906 0x00000001029b3000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_sim_platform.dylib 
[ 48] 3D717F21-33BF-32CD-A2E8-A19BA30E43DF 0x00000001029be000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_sim_pthread.dylib 
[ 49] 7FE9B462-AC91-34A8-B116-879CA0070A6E 0x00000001029c5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_trace.dylib 
[ 50] CFAF8B5B-315D-31CF-8445-721D753237F8 0x00000001029f0000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libunwind.dylib 
[ 51] BDCDB527-0E34-3346-8444-E8CEEF0377ED 0x0000000102a00000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libxpc.dylib 
[ 52] 55A5EE99-79E3-3E48-A8D6-9755BB699F71 0x0000000102a68000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_sim_pthread_host.dylib 
[ 53] 2E940813-78C3-3DD6-9B31-EA0B39541E1F 0x0000000102a6f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_sim_platform_host.dylib 
[ 54] 19AF472C-565B-3B88-962C-06BBC73BF42C 0x0000000102a77000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_sim_kernel_host.dylib 
[ 55] A4938CF5-ABC0-397B-8A6E-B7BEEFA24D0A 0x00007fff5e700000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_kernel.dylib (0x00007fff5e700000)
[ 56] 8664A4CD-EE27-3C71-B5CC-06E2B1B4F394 0x00007fff5e730000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_platform.dylib (0x00007fff5e730000)
[ 57] 17482C9D-061E-3769-AC9E-BE1239D33098 0x00007fff5e73b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/libsystem_pthread.dylib (0x00007fff5e73b000)
[ 58] F54B49BF-4621-3E6D-9BFA-82764DAB0D37 0x0000000102a7e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/liblzma.5.dylib 
[ 59] 3B6C813A-B081-377E-B042-4E43E8E4CDE2 0x0000000102aa2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Security.framework/Security 
[ 60] E3A92967-1D68-397C-A227-259BC2A6837B 0x0000000102ce8000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/SystemConfiguration.framework/SystemConfiguration 
[ 61] C75B4156-BDD6-3BE4-BFD2-4E930FC6436E 0x0000000102d9b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libapple_nghttp2.dylib 
[ 62] 642B698C-4172-3A36-80B1-C25E2FB8FE6C 0x0000000102dc0000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libnetwork.dylib 
[ 63] 1A384604-07B9-32F7-BD51-352B21F4F0F0 0x00000001034ad000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libsqlite3.dylib 
[ 64] 886CB402-2140-3AC3-8E7B-27E236CF3A70 0x000000010367f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libz.1.dylib 
[ 65] CC01B23E-4ECB-3C8E-AB93-B4E1938A895F 0x000000010369b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libbsm.0.dylib 
[ 66] C3C9381A-598E-3B29-AEC9-4CF669FFB583 0x00000001036b9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SecurityFoundation.framework/SecurityFoundation 
[ 67] D978BCC0-810F-39DE-94D4-1A2D26F8B049 0x0000000103721000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ProtocolBuffer.framework/ProtocolBuffer 
[ 68] 7970920D-CFD4-32F2-8184-D6EF649AF1CB 0x0000000103757000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libcoretls.dylib 
[ 69] 88F30683-9A36-37AE-90A0-83D3F3E0199A 0x000000010377d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libcoretls_cfhelpers.dylib 
[ 70] F978331D-A6FE-394B-A6FA-43596095AF01 0x0000000103788000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libMobileGestalt.dylib 
[ 71] 0941A110-993D-3B37-81CE-9E86140324AB 0x000000010380f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libbz2.1.0.dylib 
[ 72] 016E0A9B-A136-3B62-8988-4C4E2D0D60ED 0x0000000103824000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libiconv.2.dylib 
[ 73] 05267ED7-73EC-3597-9A20-3DBC18E1B051 0x000000010392a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libcharset.1.dylib 
[ 74] AD666685-C0A9-3A4E-8FB5-2A2F55B74AC0 0x0000000103932000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DocumentManager.framework/DocumentManager 
[ 75] E5A5D0EE-F506-32E9-8071-FDCB476EF93C 0x00000001039c4000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/FileProvider.framework/FileProvider 
[ 76] 1EF2FD00-F088-3730-A020-5D54496FEDFD 0x0000000103bf9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/UIKitCore.framework/UIKitCore 
[ 77] D593022C-2740-3E09-977C-2C36037A6548 0x000000010670c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ShareSheet.framework/ShareSheet 
[ 78] E815F473-0C4D-397E-B168-E82E8F557AFA 0x000000010688c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MobileIcons.framework/MobileIcons 
[ 79] 5DCE624A-0E69-30EE-96A0-0F95EA66DBFA 0x00000001068ac000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AssertionServices.framework/AssertionServices 
[ 80] 70B73AD6-084E-33CE-A385-2AFF18FA7C05 0x00000001068d7000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/QuartzCore.framework/QuartzCore 
[ 81] A4BCBBE1-7BC4-3BF9-8EE5-BCD04328D910 0x0000000106c99000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreServices.framework/CoreServices 
[ 82] 38BD7C4A-9A5C-33C7-A2EA-D4596C295530 0x0000000106fa7000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Network.framework/Network 
[ 83] 5D07B1AA-9698-3F09-862C-FFE0AC5EF31C 0x00000001070c5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libprequelite.dylib 
[ 84] 66F50589-F8E7-33E0-A587-BEA51616E63A 0x00000001070f5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DocumentManagerCore.framework/DocumentManagerCore 
[ 85] 629D91CF-011D-3BCB-A9DB-63E0CC983D2F 0x0000000107147000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/UniformTypeIdentifiers.framework/UniformTypeIdentifiers 
[ 86] B22B332D-7856-329F-9E73-C69000D8F0CE 0x0000000107173000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreGraphics.framework/CoreGraphics 
[ 87] 57D376BE-1E56-3D4E-854F-B77BB5C7E8AF 0x0000000107901000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MobileCoreServices.framework/MobileCoreServices 
[ 88] 721A0272-A447-3414-8A10-ACD3D5CC43E5 0x0000000107907000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreImage.framework/CoreImage 
[ 89] D622976D-4AFE-3109-8832-A68BDF1F55A1 0x0000000107edf000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreUI.framework/CoreUI 
[ 90] 3397775A-A8EA-323F-91F9-A8ECEC5774EC 0x0000000108085000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/ImageIO.framework/ImageIO 
[ 91] 90BCD9E4-7C76-377E-8DF9-A5094AEED921 0x00000001085d7000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation 
[ 92] 1D7276D0-5238-3321-AEF6-DAC635BC1828 0x0000000108654000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreServicesStore.framework/CoreServicesStore 
[ 93] 7D35E7C1-A68F-31C5-BB09-F5C707A0FB80 0x00000001086bc000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MobileSystemServices.framework/MobileSystemServices 
[ 94] 6CD1C49F-A7BC-3287-964C-02B69ECCD7B1 0x00000001086ca000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreVideo.framework/CoreVideo 
[ 95] 4FAC69BC-F71B-3B60-BDCC-B385FFF87F26 0x0000000108725000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreText.framework/CoreText 
[ 96] 4705D3EF-B3F3-3C49-B0E3-5588127A779A 0x00000001089f2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/IOSurface.framework/IOSurface 
[ 97] C312F0EF-228A-38A2-A142-7C06A8702E73 0x0000000108a19000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ColorSync.framework/ColorSync 
[ 98] 9DACC649-0486-3A87-A0C7-6D7A9077F1B7 0x0000000108b1f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accelerate.framework/Accelerate 
[ 99] 21A0AD9C-3A97-371D-8CD5-AAEA8F9F3EDD 0x0000000108b25000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Metal.framework/Metal 
[100] F4DAD523-658C-3C05-8A17-8664D0101AA3 0x0000000108e0f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/OpenGLES.framework/OpenGLES 
[101] 83DF58A6-5A30-3BF1-A44C-1304A6ED578E 0x0000000108e2c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreMedia.framework/CoreMedia 
[102] 8DC6049C-674A-373C-8511-1ACEE05E50BD 0x0000000108f7e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/VideoToolbox.framework/VideoToolbox 
[103] 9AE6AE0F-9BDA-310A-A0D0-8ECA4A25519C 0x00000001090b9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/GraphVisualizer.framework/GraphVisualizer 
[104] 4EC689F1-78ED-3492-B1E3-B0B4C964990E 0x00000001090d5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FaceCore.framework/FaceCore 
[105] B2D9675F-492F-3F57-B313-9F439D1F993E 0x00000001096fb000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libate.dylib 
[106] F2724900-42E6-37CA-A815-27BC339D4E33 0x0000000109836000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libexpat.1.dylib 
[107] 3440E550-70B7-3AC8-B7C0-C38122495C5D 0x000000010985b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AppleJPEG.framework/AppleJPEG 
[108] 03238B54-7017-3081-A342-E5B8E74A859A 0x00000001098b7000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FontServices.framework/libFontParser.dylib 
[109] ADEF4CC3-8989-33D9-97CF-B413ADADE0A5 0x0000000109b05000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FontServices.framework/libhvf.dylib 
[110] C7CA8CC5-2C7D-37F6-A932-21DCC7E6DA4B 0x0000000109b35000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accelerate.framework/Frameworks/vImage.framework/vImage 
[111] 99BC7E0C-5911-37FC-B9C3-6B2785BE319F 0x000000010a56f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accelerate.framework/Frameworks/vecLib.framework/vecLib 
[112] 43B5E1DC-8E70-3902-A877-E326D39A4814 0x000000010a575000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accelerate.framework/Frameworks/vecLib.framework/libvMisc.dylib 
[113] 3CA9029F-BDC6-3308-AD60-167C33F3FC82 0x000000010a6e0000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accelerate.framework/Frameworks/vecLib.framework/libvDSP.dylib 
[114] 87DB9A37-A529-362C-BDE2-616618C8BAF2 0x000000010a874000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accelerate.framework/Frameworks/vecLib.framework/libBLAS.dylib 
[115] D76F4E1A-DBF8-3989-841B-1769B7C18C53 0x000000010aa21000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accelerate.framework/Frameworks/vecLib.framework/libLAPACK.dylib 
[116] 1C079297-1AEF-3118-A4BB-D0DC48124BC4 0x000000010ae11000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accelerate.framework/Frameworks/vecLib.framework/libLinearAlgebra.dylib 
[117] 6C2F2CA6-B39A-3730-B5E6-04658E5AA510 0x000000010ae34000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accelerate.framework/Frameworks/vecLib.framework/libSparseBLAS.dylib 
[118] 8C7725A3-8010-3E74-AD48-24401EB169BE 0x000000010ae52000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accelerate.framework/Frameworks/vecLib.framework/libQuadrature.dylib 
[119] EC15D2C9-F655-346C-841E-1B84245E408E 0x000000010ae60000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accelerate.framework/Frameworks/vecLib.framework/libBNNS.dylib 
[120] C759D771-C66F-30CE-B724-05FFD00B8989 0x000000010b528000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accelerate.framework/Frameworks/vecLib.framework/libSparse.dylib 
[121] 598A1758-80C3-34EA-8003-EE90BD76859C 0x000000010b5af000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/OpenGLES.framework/libCoreFSCache.dylib 
[122] B0EC14EF-D0AF-363F-A3DC-6D445B03B162 0x000000010b5bf000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/OpenGLES.framework/libGFXShared.dylib 
[123] B0158AF8-18C8-3FB5-B7A0-4063F3BB7D06 0x000000010b5d4000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/OpenGLES.framework/libGLImage.dylib 
[124] B3FAAB52-6B06-3B5E-8032-68F61CFB2A09 0x000000010b620000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/OpenGLES.framework/libCVMSPluginSupport.dylib 
[125] FD145937-5DD6-3907-BEF1-87E1DAA95C36 0x000000010b62c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/OpenGLES.framework/libCoreVMClient.dylib 
[126] E62A80DA-0217-307E-9978-1D43C67F1385 0x000000010b640000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/OpenGLES.framework/libLLVMContainer.dylib 
[127] 4EF188E2-43EB-3C4F-ABFC-35C5EA85BC80 0x000000010c6aa000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FontServices.framework/libGSFontCache.dylib 
[128] D3BA0D5E-A93C-3A23-AE06-444EAB10CEAD 0x000000010c855000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FontServices.framework/libGSFont.dylib 
[129] 7D2CEA42-1EF5-3702-AC05-384B22491426 0x000000010c86e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libAccessibility.dylib 
[130] 16E18DA2-8CB3-33A9-A2DE-800E6CD3E7BE 0x000000010c8bc000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/OTSVG.framework/OTSVG 
[131] A4341FE5-F8E1-3BB4-8B12-EEE63A3A02B9 0x000000010c958000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FontServices.framework/FontServices 
[132] AB7C49EF-3C3D-327A-8DC2-8AD5BC2F13F4 0x000000010c982000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices 
[133] AF44A147-2C6F-3F4D-9D21-2FB065EC25B9 0x000000010ca6d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IdleTimerServices.framework/IdleTimerServices 
[134] 46262852-C994-3701-9CB5-06331AE82019 0x000000010ca87000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/BoardServices.framework/BoardServices 
[135] 413D640A-A8F6-3710-AD36-626D9574FD9A 0x000000010cae4000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FrontBoardServices.framework/FrontBoardServices 
[136] 4AA6F895-A84F-3B16-B5BC-73A18D3B7A39 0x000000010cc26000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/BaseBoard.framework/BaseBoard 
[137] 5FC96179-C9E6-3DC3-B9CA-4E63BB5597B4 0x000000010cd40000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/BackBoardServices.framework/BackBoardServices 
[138] DF3DC049-3CA9-3251-BDBC-DAED31BE1EA5 0x000000010ce37000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/GraphicsServices.framework/GraphicsServices 
[139] BB564E23-E9F0-3B12-ABB5-09B3947B559F 0x000000010ce53000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PersistentConnection.framework/PersistentConnection 
[140] 1447C4F3-7903-3F1E-B4B3-39F5622E7CAB 0x000000010ceaf000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CommonUtilities.framework/CommonUtilities 
[141] 740EA461-90A0-3024-9442-25F018D386BF 0x000000010cee1000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony 
[142] 2C381D43-55CC-3D01-9568-1B561C31FFE7 0x000000010d0fb000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Bom.framework/Bom 
[143] 64553DE6-4AB3-3287-A640-E7982F15BC9B 0x000000010d146000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libcupolicy.dylib 
[144] 6B940D40-CB09-3531-8A60-27645828AB21 0x000000010d158000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libTelephonyUtilDynamic.dylib 
[145] E69A081C-7450-3EFF-AC54-AAF8A6BE84BB 0x000000010d208000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/RunningBoardServices.framework/RunningBoardServices 
[146] 5C857D96-A4D1-3AB6-BA14-0F8C3D1810A6 0x000000010d2c2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AXCoreUtilities.framework/AXCoreUtilities 
[147] E64BFA74-9043-315B-9BDD-B690F049355F 0x000000010d2f2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MediaAccessibility.framework/MediaAccessibility 
[148] 7A8E5974-E1A7-3AC5-AFAB-25E9C13DCB08 0x000000010d312000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libperfcheck.dylib 
[149] 83982F24-8378-3D3D-A454-527BA852195D 0x000000010d32f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/perfdata.framework/perfdata 
[150] AAD7AAB2-720B-3277-9C87-2F14E8044829 0x000000010d357000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CMCaptureCore.framework/CMCaptureCore 
[151] CA1CDB51-FAF2-324E-B902-A0BF31C48CA9 0x000000010d3af000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SimulatorClient.framework/SimulatorClient 
[152] 7F7999AC-0C3A-399D-BB9D-B05FB691C745 0x000000010d3bb000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreAudio.framework/CoreAudio 
[153] 75FD334E-62EB-357D-91FD-7D33A87926DB 0x000000010d4e5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SimFramebufferClient.framework/SimFramebufferClient 
[154] CBC6A940-87C1-3973-A4AC-8F53E7F767C7 0x000000010d502000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/caulk.framework/caulk 
[155] AD732E60-28B4-35B6-B981-3DE95522CBF8 0x000000010d56a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/TextureIO.framework/TextureIO 
[156] 9C5C1F17-DA9E-3A17-8EEC-1E1F86BFCE11 0x000000010d670000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreSVG.framework/CoreSVG 
[157] 41D5D246-E020-3763-AB5C-A7DBDF4CF058 0x000000010d6b9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/InternationalSupport.framework/InternationalSupport 
[158] 24534711-3E6E-3A95-982B-2CF083E29826 0x000000010d6cf000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AppSupport.framework/AppSupport 
[159] D56F570B-FE3C-3A5C-B5B5-AA806A4500DD 0x000000010d755000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreUtils.framework/CoreUtils 
[160] F479E95F-AF21-3079-BA7A-A2060E0FE969 0x000000010da40000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IconServices.framework/IconServices 
[161] 89434FFB-1D92-390C-974E-A5B09C78C83B 0x000000010daae000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/UIFoundation.framework/UIFoundation 
[162] 23FCB2DF-D01D-3583-BDCA-3359E1CF5801 0x000000010dcbc000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/PushKit.framework/PushKit 
[163] 4BFD82B3-8B6F-350D-882E-9332F5CA316E 0x000000010dcd5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/XCTTargetBootstrap.framework/XCTTargetBootstrap 
[164] 69F88FF0-AB9C-38B2-BADF-5FD326CA11B0 0x000000010dce4000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/WebKitLegacy.framework/WebKitLegacy 
[165] C4A0E92E-BDAB-3958-9755-CD52F42A0240 0x000000010dffa000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AggregateDictionary.framework/AggregateDictionary 
[166] A3722980-1604-3658-A1BE-DE37D528FC50 0x000000010e00a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ManagedConfiguration.framework/ManagedConfiguration 
[167] 23A6E7FA-88AF-3DB5-8826-63E9C460F75D 0x000000010e266000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libapp_launch_measurement.dylib 
[168] B3448322-00B6-31F1-BED2-34D6165623D5 0x000000010e272000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PointerUIServices.framework/PointerUIServices 
[169] 2AA9A496-A473-32A4-97C4-AF68C64FFFDF 0x000000010e299000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreMaterial.framework/CoreMaterial 
[170] 2FD43614-BFAA-3ECC-9F5C-7560198CA7E6 0x000000010e2e2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Pasteboard.framework/Pasteboard 
[171] 7B113DB9-19C7-3C53-907D-AFA3756713D6 0x000000010e340000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreAnalytics.framework/CoreAnalytics 
[172] A4862EE5-46A9-3E23-8B22-5A198A1C90A5 0x000000010e38b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/UserNotifications.framework/UserNotifications 
[173] 8EE4BE1C-3500-3524-A5ED-8EFD6D43AD98 0x000000010e404000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MobileAsset.framework/MobileAsset 
[174] 1D8D2BAF-B260-30C7-B1BB-01F01265BCFD 0x000000010e457000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PhysicsKit.framework/PhysicsKit 
[175] 79F8840F-41AA-30F1-9069-6AE6B9C17F92 0x000000010e4e5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PrototypeTools.framework/PrototypeTools 
[176] F517EF66-3801-380A-A8C5-330EDE822D8D 0x000000010e536000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/TextInput.framework/TextInput 
[177] C0234301-A713-38CF-9D01-671BBFC084B1 0x000000010e6b6000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/UIKitServices.framework/UIKitServices 
[178] 7FF4FB5B-1E88-3919-931E-B6DD41CB87C9 0x000000010e6ed000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/JavaScriptCore.framework/JavaScriptCore 
[179] 4868068E-EF0F-300E-9827-EDCF9ED80B32 0x0000000110332000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/WebCore.framework/WebCore 
[180] B2A18A69-EDE7-33F1-B622-03980672544E 0x00000001139f8000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/WebCore.framework/Frameworks/libwebrtc.dylib 
[181] 4F81C8B7-EAE9-3130-856D-9D7BD0CBB0C0 0x000000010fcad000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/URLFormatting.framework/URLFormatting 
[182] 3BC179B0-CD5E-3300-A411-CCC93F9D219E 0x000000010fcc1000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/AudioToolbox.framework/AudioToolbox 
[183] 180AED1F-8E6E-3E66-8BE6-CAF81A8CB7D3 0x000000010fec2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CorePhoneNumbers.framework/CorePhoneNumbers 
[184] AFD79E18-E64F-3857-B89B-A15EE68DBF48 0x0000000114569000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AudioToolboxCore.framework/AudioToolboxCore 
[185] 36F48F70-A278-330E-AE6B-308498B5249D 0x000000010fed7000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/TCC.framework/TCC 
[186] 3272DAF9-287C-3319-A336-3449D83282CB 0x000000010feff000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MediaExperience.framework/MediaExperience 
[187] CE51C30C-711C-3B59-8C3F-B3B5F25888E6 0x000000010ff10000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libAudioStatistics.dylib 
[188] C7449C52-DCAB-3E9C-9EA9-3048D33EA016 0x000000010ff34000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libAudioToolboxUtility.dylib 
[189] B1F0E1FB-CE0B-3DE2-8C83-37F4360A8393 0x000000010ff95000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/UserManagement.framework/UserManagement 
[190] 03E9A2B0-B619-3D35-8F59-75BAC16264DD 0x000000010ffdf000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DataMigration.framework/DataMigration 
[191] 2EF5910B-8674-3FC7-820D-34733CCD9A19 0x0000000110007000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accounts.framework/Accounts 
[192] F19F5D88-D838-30DD-831D-096ABBBE7B7B 0x0000000114a6e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreData.framework/CoreData 
[193] C74EC675-2C3B-3DA2-A0F9-87562E46E97B 0x00000001100ea000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DragUI.framework/DragUI 
[194] C1243682-EB82-30A9-91AE-AC4632C1A750 0x00000001100f7000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/GenerationalStorage.framework/GenerationalStorage 
[195] 94221707-0887-3A31-B67D-9B72F1E866B1 0x0000000110138000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ChunkingLibrary.framework/ChunkingLibrary 
[196] CFD5AC45-BB20-30DD-93ED-B6049FB8BB86 0x00000001101d9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AppleSauce.framework/AppleSauce 
[197] A681F8DF-29F3-37D6-8627-417C9A38915C 0x00000001150b9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ExtensionKit.framework/ExtensionKit 
[198] 94CFB77A-D31E-3C1C-92A1-A741149082B2 0x00000001150fc000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PlugInKit.framework/PlugInKit 
[199] AC7D80D1-A3EB-371F-B856-7263A37A4FC7 0x000000011514d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ExtensionFoundation.framework/ExtensionFoundation 
[200] 6730FAB1-A579-3505-9A1B-4ED1CF4E56ED 0x0000000115163000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/StreamingZip.framework/StreamingZip 
[201] FE8EBCA0-3621-367C-8F32-75AF9668E21B 0x00000001151d1000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ConstantClasses.framework/ConstantClasses 
[202] 1BBC455D-E0BD-3E35-B4DE-DE8CB6C6B1BF 0x0000000100820000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libBacktraceRecording.dylib 
[203] 4D66E326-07A0-3600-8D7C-FB2FD32E6890 0x0000000100833000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libMainThreadChecker.dylib 
[204] A7922882-E111-3BE7-94D2-D8E57D66AD30 0x0000000100969000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/Developer/Library/PrivateFrameworks/DTDDISupport.framework/libViewDebuggerSupport.dylib 
[205] A8D408C2-CAD2-3B91-918E-0E328C02489F 0x00000001151df000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/Developer/Library/PrivateFrameworks/DebugHierarchyFoundation.framework/DebugHierarchyFoundation 
[206] A0D6E882-ECF1-33F4-B1DB-2607F06BB912 0x0000000115221000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/GLKit.framework/GLKit 
[207] 5B29A59D-87FC-3C94-9AC6-9460552878CE 0x000000011528c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/SceneKit.framework/SceneKit 
[208] 02B82F5F-0CDB-3AD2-8BB0-7378E60DFA42 0x00000001159a1000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MapKit.framework/MapKit 
[209] 4DC8A53C-0421-3C55-916B-BE412DDAF604 0x0000000115fbb000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/ModelIO.framework/ModelIO 
[210] 6BF55860-52E7-3788-86CE-031B5BD6215C 0x000000011020d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/AVFoundation.framework/AVFoundation 
[211] 17D7D1DD-D73F-3C69-8883-E405A75EC5E1 0x0000000116c31000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MetalKit.framework/MetalKit 
[212] 665E5EFB-B802-3C35-B08A-8BCFE0DADC4D 0x0000000116c71000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreSymbolication.framework/CoreSymbolication 
[213] 1DC15823-5C4A-3620-AC57-2F7E4061AB5A 0x0000000116d97000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MetalPerformanceShaders.framework/MetalPerformanceShaders 
[214] 60E41716-B83B-3C7E-B733-0A36E96327AF 0x0000000116d9f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AVFCore.framework/AVFCore 
[215] F0ABDC15-CFE7-38CF-99AF-5EB8885778F0 0x000000011712c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/AVFoundation.framework/Frameworks/AVFAudio.framework/AVFAudio 
[216] 624D59AF-76CC-339E-801B-A7BADEB2FD0A 0x00000001172c5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AVFCapture.framework/AVFCapture 
[217] 513B420E-3AF7-3CD9-AEB1-FE704C7FD674 0x0000000117481000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AirPlaySync.framework/AirPlaySync 
[218] C16C550F-086E-30F6-8081-B5237286401B 0x00000001175b9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MediaToolbox.framework/MediaToolbox 
[219] A92496D7-5563-3327-82D2-BF66D12F902A 0x0000000117d1c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Celestial.framework/Celestial 
[220] C75EC83A-8D6B-39E1-A4AE-070FBDB3AAC2 0x0000000117d45000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AudioSession.framework/AudioSession 
[221] C7A05660-23B2-386C-A779-32747E7F6CF2 0x0000000117d7a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CMCapture.framework/CMCapture 
[222] 72708ED5-0EAD-3B21-AC94-F838E48E26EF 0x0000000117e30000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Quagga.framework/Quagga 
[223] 2CA8C29F-B441-3936-BFB8-FB8C0B94FDBE 0x0000000117ee7000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Espresso.framework/Espresso 
[224] 79A9B7FE-0496-3446-974B-7B89181DE509 0x0000000118a03000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MetalPerformanceShaders.framework/Frameworks/MPSCore.framework/MPSCore 
[225] EC5D3E8D-3B46-3C79-8284-3397E66EFA61 0x0000000118a96000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MetalPerformanceShaders.framework/Frameworks/MPSImage.framework/MPSImage 
[226] B37646BF-95FD-363B-B818-4FE427A742DE 0x0000000118ba7000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MetalPerformanceShaders.framework/Frameworks/MPSNeuralNetwork.framework/MPSNeuralNetwork 
[227] F26A1D98-D0E1-3CAE-8286-D9350347C484 0x0000000118e95000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MetalPerformanceShaders.framework/Frameworks/MPSMatrix.framework/MPSMatrix 
[228] D01C13C6-1F64-3D56-B23A-7082C897EA34 0x0000000118ee2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MetalPerformanceShaders.framework/Frameworks/MPSRayIntersector.framework/MPSRayIntersector 
[229] 9315841F-2D0D-3A29-8D33-0A2C1B4AA881 0x0000000118f50000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MetalPerformanceShaders.framework/Frameworks/MPSNDArray.framework/MPSNDArray 
[230] 921D3431-24C0-308F-ADE1-6BFBDDAF2E69 0x0000000118fc7000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MetalTools.framework/MetalTools 
[231] 88C69923-A4F5-3FA2-95D0-DBCA3096D2ED 0x00000001191e5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/ContactsUI.framework/ContactsUI 
[232] 2ED6E41D-96ED-3EE9-AC0F-90D3DCBAA68E 0x00000001196ad000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Contacts.framework/Contacts 
[233] 3F6EFEFF-FCAB-34AF-BB3E-C7FAB927A046 0x00000001199dc000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SearchFoundation.framework/SearchFoundation 
[234] 9C19777F-C3F9-3DD6-BA27-A2F1141AA39E 0x0000000119e49000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Intents.framework/Intents 
[235] D224F7AE-03D3-3E4C-A92A-A7C45603805B 0x000000011aa39000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Navigation.framework/Navigation 
[236] BEEA51A2-B623-3BD6-9ADE-4DC1062AB31D 0x000000011ace1000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/VectorKit.framework/VectorKit 
[237] E720F556-E576-3E73-AE66-A1508B27FFBF 0x000000011bd03000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreLocation.framework/CoreLocation 
[238] F8BE51B4-0787-300D-8B0A-6B1451143B16 0x000000011bdc5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/GeoServices.framework/GeoServices 
[239] 6558364B-6750-358A-B802-B154C5E45682 0x000000011e19d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AddressBookLegacy.framework/AddressBookLegacy 
[240] E98FBDEA-FBEE-388C-BE8E-75A3A2CFD9A7 0x000000011e2c5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AppSupportUI.framework/AppSupportUI 
[241] 80ECD1E1-A4CF-3DAC-A99D-F22373D65EE7 0x000000011e320000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DataAccessExpress.framework/DataAccessExpress 
[242] 360540F5-7B95-33DF-943D-C3C8A937F87C 0x000000011e39b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PersonaKit.framework/PersonaKit 
[243] 0306BB46-0A74-35DE-BD96-E7E4E16B9EE7 0x000000011e3b9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PersonaUI.framework/PersonaUI 
[244] 946D00CD-FB9E-3069-94C0-258C277F1069 0x000000011e3de000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CommunicationsFilter.framework/CommunicationsFilter 
[245] 216E0B0C-6CBE-3752-B36D-1C25A1CEE1B3 0x000000011e3ef000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ContactsDonation.framework/ContactsDonation 
[246] B472C7B1-BBBC-3F84-85F0-80F72A421027 0x000000011e433000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ContactsFoundation.framework/ContactsFoundation 
[247] 5CC92DC6-BE7C-3498-B83C-5F96094D55CC 0x000000011e5ab000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/EmojiFoundation.framework/EmojiFoundation 
[248] 33832FBD-473F-3799-816C-AC12CEB8491E 0x000000011e672000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ContactsUICore.framework/ContactsUICore 
[249] 7CE55D29-299B-3A60-B89E-3A5B4E6E7F53 0x000000011e7aa000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FamilyCircle.framework/FamilyCircle 
[250] 8D0FD7BA-FA43-3458-935A-9082D2C5EEF9 0x000000011e7ee000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IntlPreferences.framework/IntlPreferences 
[251] 022BD91C-D270-334B-9B91-8D8AD8794ECB 0x000000011e82c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/OnBoardingKit.framework/OnBoardingKit 
[252] 319E500B-B218-3492-AEBC-AB605485B99D 0x000000011e8da000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreEmoji.framework/CoreEmoji 
[253] A935A439-1239-3BC4-904A-88C8FCF17133 0x000000011e906000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/vCard.framework/vCard 
[254] 990538D1-1BB0-39B1-85B0-3B2B08B698A9 0x000000011e98a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/TemplateKit.framework/TemplateKit 
[255] 8745710B-9898-36D8-A094-93D44A39B209 0x000000011ea2a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libCTGreenTeaLogger.dylib 
[256] 73EE56AC-B1CD-36BA-B2AA-02AF4778D000 0x000000011ea35000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DataDetectorsCore.framework/DataDetectorsCore 
[257] DF77A8EC-9400-3715-8D62-44B9C7784572 0x000000011ea9f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreNLP.framework/CoreNLP 
[258] 25CE11E8-9BA8-33F4-8D4A-D6335126EA41 0x000000011eb8c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libmecab.dylib 
[259] 9D35102D-BABE-34F5-B2EC-AA8F2ECC403F 0x000000011ec12000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libgermantok.dylib 
[260] 6BC8CD35-FC2A-352A-B15F-FF62F3F4C26B 0x000000011ec20000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libThaiTokenizer.dylib 
[261] 2BA2FC39-ED89-3817-A210-E9D818AD0CE0 0x000000011ec2a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libChineseTokenizer.dylib 
[262] 642CB3FC-9799-3660-AF4F-6815BF303C5F 0x000000011ec43000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/LanguageModeling.framework/LanguageModeling 
[263] 158F17CA-9F46-34C4-9C75-DA521D92866D 0x000000011ed72000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/LinguisticData.framework/LinguisticData 
[264] AD133B42-EBAA-309A-9495-D90122DE6B76 0x000000011ed81000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Lexicon.framework/Lexicon 
[265] 51C07E10-99F9-3869-82E2-2E3693B0566B 0x000000011ede8000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libcmph.dylib 
[266] C5A294C7-0CBA-3558-BE95-7064D37951E2 0x000000011ee06000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IMFoundation.framework/IMFoundation 
[267] 0BFC1C45-4FEA-3DF9-B180-8AC3AACBE158 0x000000011eec9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Marco.framework/Marco 
[268] 95B3853E-79A7-3037-8D8D-2B8C0CA4B59C 0x000000011eed2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CellularPlanManager.framework/CellularPlanManager 
[269] EF691640-376C-3C1D-B46E-7FFB4C3E380D 0x000000011ef2c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/ClassKit.framework/ClassKit 
[270] E6763A05-79A2-3270-851A-F2309E9CDDFC 0x000000011f021000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreSuggestions.framework/CoreSuggestions 
[271] D190411E-F1D8-335F-96D8-2A61ECDE09E3 0x000000011f183000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PhoneNumbers.framework/PhoneNumbers 
[272] 9D5FD0EF-8C22-305B-9D65-A289356ABA36 0x000000011f18c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CloudKit.framework/CloudKit 
[273] CA9342A7-7D04-307B-9EE7-7B032271CF93 0x000000011f505000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CloudDocs.framework/CloudDocs 
[274] B35DF654-E6B7-36A1-A686-A7B94BEE2C98 0x000000011f616000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/QuickLookThumbnailing.framework/QuickLookThumbnailing 
[275] D4255AF2-0489-328B-860E-F10DB5DD316B 0x000000011f6a6000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ApplePushService.framework/ApplePushService 
[276] C8A1B034-2D68-310C-9AC2-64A324D8AAC2 0x000000011f6e9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/C2.framework/C2 
[277] B8E2070F-5BFB-34D2-84BF-415A97198709 0x000000011f76b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ProtectedCloudStorage.framework/ProtectedCloudStorage 
[278] A6E18591-E88B-3F49-AF8D-24784C017D8F 0x000000011f803000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreTime.framework/CoreTime 
[279] AE182754-9A63-39A9-8B99-79881400E4BD 0x000000011f819000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AuthKit.framework/AuthKit 
[280] 91AE6F5E-CB05-3748-9193-DCBFB779AC72 0x000000011f957000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/LocalAuthentication.framework/LocalAuthentication 
[281] D13EDE3C-E017-369E-AC4F-363930A5B5F6 0x000000011f98b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AppleIDAuthSupport.framework/AppleIDAuthSupport 
[282] C22C1820-F2AE-3DC9-A97D-61730A769A3C 0x000000011f9ab000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/LocalAuthentication.framework/Support/SharedUtils.framework/SharedUtils 
[283] 9798DC25-2E8A-3F77-AE2D-7DBB9CF70C27 0x000000011fa01000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/LocationSupport.framework/LocationSupport 
[284] A7050126-4283-3A49-8393-D9210580DDE4 0x000000011fa44000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreBluetooth.framework/CoreBluetooth 
[285] 5997CABF-E377-35B6-A478-0B15FBFA1EFA 0x000000011fb42000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreLocationProtobuf.framework/CoreLocationProtobuf 
[286] 32CDEDE8-23AA-3819-94C4-C9C77C16399C 0x000000011fc05000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libheimdal-asn1.dylib 
[287] 2D78401F-C6E8-3E18-A2AF-C03DD8A8F307 0x000000011fc14000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/NanoRegistry.framework/NanoRegistry 
[288] 6A763BE0-F763-3A25-B6A7-F4D947F9A8C9 0x000000011fcf5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MobileSpotlightIndex.framework/MobileSpotlightIndex 
[289] 6986147B-740F-3999-9E2B-964C89AA5D6E 0x000000012007e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SpotlightLinguistics.framework/SpotlightLinguistics 
[290] E6D9864A-6CD1-389F-B47D-D9560CA65A57 0x000000012009d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MetadataUtilities.framework/MetadataUtilities 
[291] 18884C53-7838-3F7D-864B-AA47A7BEA46F 0x0000000120114000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ProactiveSupport.framework/ProactiveSupport 
[292] 4C3AC224-C1E3-32D1-88B9-133F83C3673B 0x00000001201f1000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DataDetectorsNaturalLanguage.framework/DataDetectorsNaturalLanguage 
[293] D8695619-0477-3C15-A46D-D7C9566A7DBA 0x000000012026d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreSpotlight.framework/CoreSpotlight 
[294] 7D928B17-43B6-3873-8BEE-9350D76C9805 0x000000012036e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ProactiveEventTracker.framework/ProactiveEventTracker 
[295] AB9A27DC-EBD3-3224-8C24-141150C28E87 0x00000001203bd000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IntentsFoundation.framework/IntentsFoundation 
[296] 32469887-5AC9-314B-B876-A42E2EC408E8 0x00000001203e2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/InternationalTextSearch.framework/InternationalTextSearch 
[297] 7E479770-30A1-3D25-B4B1-E76A4F352C9A 0x00000001203ef000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/RTCReporting.framework/RTCReporting 
[298] C6315451-E57A-342E-89E0-050141498404 0x000000012040e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/EventKit.framework/EventKit 
[299] 5F98C661-7B3E-34A2-9035-F0A3AFC3A294 0x00000001206a0000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ResponseKit.framework/ResponseKit 
[300] 6A64822E-1CF1-31F3-B093-7EE450D29AA5 0x0000000120885000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CalendarDatabase.framework/CalendarDatabase 
[301] EB1DAEEF-E0E3-31F4-A4D1-BDE461A0FA24 0x00000001209bd000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CalendarDaemon.framework/CalendarDaemon 
[302] 717D27FF-9C10-334E-A7D1-BE5852C75772 0x0000000120a91000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CalendarFoundation.framework/CalendarFoundation 
[303] 192805F7-6766-35DD-A972-A232D4F60AFA 0x0000000120b7e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/iCalendar.framework/iCalendar 
[304] EF31A303-0745-3507-98D1-F45D8462CC9D 0x0000000120bf6000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreDAV.framework/CoreDAV 
[305] D8E87BBE-8037-368F-AA97-C21F990C591D 0x0000000120d10000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libresolv.9.dylib 
[306] 368D986B-10E1-3139-95D0-7374814AAC2E 0x0000000120d37000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/NLP.framework/NLP 
[307] 16E8F417-4025-3F7A-8B9B-3F11904088A1 0x0000000120eb9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Montreal.framework/Montreal 
[308] 340B23C5-8301-38F8-8F01-3107570FA124 0x0000000121087000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreDuet.framework/CoreDuet 
[309] 27ABAA9F-E498-3691-A34E-7309E0504021 0x0000000121442000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreRecents.framework/CoreRecents 
[310] 6B8519F0-644D-3D36-BAD9-D03C7B2D7C51 0x0000000121466000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreDuetDebugLogging.framework/CoreDuetDebugLogging 
[311] 3744EF6A-2660-3B8C-A79A-3987C4CF6FC2 0x0000000121471000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreDuetDaemonProtocol.framework/CoreDuetDaemonProtocol 
[312] 216F9BB2-53C0-3C36-9381-BFBB1EBE2552 0x0000000121496000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Rapport.framework/Rapport 
[313] F69FAC71-7FFA-3635-85F7-9AC6334429F6 0x0000000121595000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreFollowUp.framework/CoreFollowUp 
[314] C2E05CFD-6319-3DEE-8717-D548BE401448 0x00000001215d3000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AppleMediaServices.framework/AppleMediaServices 
[315] C0D4F11F-CA22-3505-9C4C-13A21383889B 0x0000000121945000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AppleAccount.framework/AppleAccount 
[316] A0E779BB-3C67-35AB-9011-EF8F81501936 0x0000000121b33000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AppleIDSSOAuthentication.framework/AppleIDSSOAuthentication 
[317] C9C9EE73-DD48-3A72-9968-1B193EAE6515 0x0000000121b4f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CryptoTokenKit.framework/CryptoTokenKit 
[318] 1A252A5A-0E2B-391F-AFAC-13183000A68C 0x0000000121be7000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FeatureFlagsSupport.framework/FeatureFlagsSupport 
[319] 603CCAE4-F3B9-3BEC-BFB4-6F1399998C94 0x0000000121bf8000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SetupAssistant.framework/SetupAssistant 
[320] B5C41FCD-D29A-36D2-A895-6D72A4E0CED4 0x0000000121c6a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CloudServices.framework/CloudServices 
[321] 90ED96AD-D84F-3639-AEE0-0596E2BDFB9F 0x0000000121cae000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/NanoPreferencesSync.framework/NanoPreferencesSync 
[322] F1853DF6-B2E1-3885-A9F1-389CFABE9DD7 0x0000000121cd6000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AppConduit.framework/AppConduit 
[323] 0616EE3A-3E3A-381C-83BC-351976425341 0x0000000121d19000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/OctagonTrust.framework/OctagonTrust 
[324] 7F846F8F-F6E6-3D1E-ACB0-DE023AB9E660 0x0000000121d4c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/VirtualGarage.framework/VirtualGarage 
[325] 2A889FE1-C8ED-3801-8825-98E7C90FBE44 0x0000000121daf000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/VoiceServices.framework/VoiceServices 
[326] EFD8D3E2-7204-3ED5-95BD-33159D7AF6F8 0x0000000121e50000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreMotion.framework/CoreMotion 
[327] 3E62950C-103F-3AC3-AC2D-A24A6FD6DB84 0x00000001220a0000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IntentsCore.framework/IntentsCore 
[328] 7E8DFBC8-6206-33BB-A007-03E9F15D0BF5 0x00000001220e2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/ExternalAccessory.framework/ExternalAccessory 
[329] C348F4F3-C962-3223-A156-DA7264FF275B 0x0000000122122000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MediaRemote.framework/MediaRemote 
[330] 24ADC7C0-9A45-3220-8AB2-FD2C8EC9B1F6 0x00000001225c4000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/RemoteTextInput.framework/RemoteTextInput 
[331] 581789D2-3AC9-3F00-9937-CC0EAB238035 0x00000001225f3000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MediaServices.framework/MediaServices 
[332] F90D273C-440F-3A1A-8469-4CB6EBD926B3 0x0000000122688000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IDS.framework/IDS 
[333] E4C398A6-3E37-37EE-AFB1-621971FB7E89 0x0000000122827000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IDSFoundation.framework/IDSFoundation 
[334] 19A2DA6D-A538-36C4-B770-0B035CA1BF76 0x0000000122a95000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Engram.framework/Engram 
[335] DC622733-725D-339B-9B54-1C9C977F6550 0x0000000122ac0000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/BluetoothManager.framework/BluetoothManager 
[336] 79FAF0E0-E017-3030-865C-6F660D2AF516 0x0000000122ae4000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IAP.framework/IAP 
[337] 9ABE7B13-CFBA-3B80-AE72-0D9D9D46A665 0x0000000122b1d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MobileBluetooth.framework/MobileBluetooth 
[338] D18B7288-17C4-3AC9-89D7-B71BDE2CFE52 0x0000000122b3f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SiriTTS.framework/SiriTTS 
[339] 77142DF5-56E9-38A4-B56B-88870197C197 0x000000012347b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreML.framework/CoreML 
[340] 7BA6161E-4D8F-377D-A232-74368597F38A 0x0000000123a8a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libedit.3.dylib 
[341] AEC6DF69-11D8-344A-BF94-9B0AC4BF0C06 0x0000000123aba000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libncurses.5.4.dylib 
[342] C30AA0D8-563B-3967-A5B0-584C4F99E0DC 0x0000000125998000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libobjc-trampolines.dylib 
[343] D8E25248-DDB3-3EA8-ADCD-92E2988A589E 0x00000001259bb000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/AccessibilityBundles/AccessibilitySettingsLoader.bundle/AccessibilitySettingsLoader 
[344] EAA1039B-D140-36A7-9DC5-B1441F51CC27 0x00000001259ff000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libAXSafeCategoryBundle.dylib 
[345] 2EF3E4A1-B1D8-3FA7-B2C7-6AE7ADD74C44 0x0000000125a0b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/AccessibilityBundles/UIKit.axbundle/UIKit 
[346] 00DC7E76-DDAA-3CA2-99D0-8BF094DD2FFF 0x0000000125cbf000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AccessibilityUIUtilities.framework/AccessibilityUIUtilities 
[347] 45B9D01E-F591-3417-9DFD-F4A7D33205D2 0x0000000125d75000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SpeakTypingServices.framework/SpeakTypingServices 
[348] 46186B04-B191-39B5-8403-6479819BABE2 0x0000000125d81000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/RTTUtilities.framework/RTTUtilities 
[349] 25E4210B-D1CE-36D0-9943-6847D113CF86 0x0000000125ddf000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AXFrontBoardUtils.framework/AXFrontBoardUtils 
[350] 47E2AC78-717B-3022-8F8A-9F1DC8411B10 0x0000000125df9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AccessibilitySharedSupport.framework/AccessibilitySharedSupport 
[351] 26510A42-58DB-3908-8EFF-64ACA40EDB26 0x0000000125e91000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FrontBoard.framework/FrontBoard 
[352] C63B21F5-5185-3AEA-9F70-3CA63A724AB8 0x0000000125fae000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ScreenReaderCore.framework/ScreenReaderCore 
[353] 5152A330-4C50-325E-A9BE-4D9A18137D32 0x000000012602c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SpeakThisServices.framework/SpeakThisServices 
[354] AC1DC684-21A8-3862-8D15-1A6A30DBEFC1 0x000000012603a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AXMediaUtilities.framework/AXMediaUtilities 
[355] 9C320D2F-9D3E-3FF4-8C45-8F4BF064225D 0x0000000126191000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AXRuntime.framework/AXRuntime 
[356] 8CDAF793-8872-3449-954A-28C36C91F543 0x0000000126267000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/UIAccessibility.framework/UIAccessibility 
[357] 304A10B8-3AC9-3CE2-A586-20CA3CA403D1 0x0000000126394000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AccessibilityUtilities.framework/AccessibilityUtilities 
[358] 2087ABA0-AF6E-3E5F-A90C-60B3C8CB97D2 0x00000001265b1000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Preferences.framework/Preferences 
[359] 92F2BD72-AA8C-3254-B259-863546E1DCFB 0x000000012680c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ScreenReaderOutput.framework/ScreenReaderOutput 
[360] 86FAA945-ED6E-3D36-8FD1-DBC682946DB0 0x00000001268ad000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Accessibility.framework/Accessibility 
[361] ECD0FC9D-24D3-37CC-AE15-FF5D9F1C100E 0x00000001268bb000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/VoiceOverServices.framework/VoiceOverServices 
[362] 0E647A2B-63D5-35BD-8C4A-17F64E379556 0x000000012694a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SettingsFoundation.framework/SettingsFoundation 
[363] 3E3233DE-5FD8-3619-B904-BFF301002E8E 0x0000000126970000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreBrightness.framework/CoreBrightness 
[364] 3EC57AEE-EBB5-3071-91FC-37F2CF48C2E8 0x000000012697d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/NetAppsUtilities.framework/NetAppsUtilities 
[365] DF0BE3F8-88F1-3C82-AFE4-D192D5BCEDD8 0x00000001269db000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/NetworkExtension.framework/NetworkExtension 
[366] 37EBA987-3A25-333F-A0C6-82F359506E08 0x0000000126e59000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libAWDSupport.dylib 
[367] 2A8BA5D2-9E7A-3634-97F0-5A5050B2106D 0x0000000126ea2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libutil.dylib 
[368] DD7500E6-C345-3B55-9F69-BB0383A01214 0x0000000126eaf000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/BiometricKit.framework/BiometricKit 
[369] 1BBAD9BA-29D5-365F-8E18-965BD33138C9 0x0000000126ed7000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CaptiveNetwork.framework/CaptiveNetwork 
[370] 59881F3E-FFCE-3E99-975B-75B38F567DD4 0x0000000126ee3000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libnetworkextension.dylib 
[371] 9639FE5C-80B1-3EA2-874F-CD38FC197A55 0x0000000126f0c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libprotobuf-lite.dylib 
[372] EC0E3E93-BF20-3D34-BD0F-51DF2658ACA7 0x0000000126f3a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libprotobuf.dylib 
[373] 51A6786E-C3A3-3A62-8EBF-708D1519F44E 0x0000000126ffd000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/BrailleTranslation.framework/BrailleTranslation 
[374] B7F9BE27-64E8-34C0-8442-E177049F33CF 0x0000000127029000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Sharing.framework/Sharing 
[375] AC96075B-5C00-3500-9229-27FB4C30324B 0x00000001272f5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreMIDI.framework/CoreMIDI 
[376] 29760365-F2D4-38DA-8F48-8A6FFDAD70B7 0x00000001273ad000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/TextToSpeech.framework/TextToSpeech 
[377] 285E5321-904C-3F6C-986B-7D0873E7C190 0x00000001273eb000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AssistantServices.framework/AssistantServices 
[378] 62EC416D-B3FD-31C6-BC1E-A47CD6DFAA7C 0x0000000127783000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libAXSpeechManager.dylib 
[379] 180F973B-A407-3E50-A630-1D7EADB19E16 0x00000001277ab000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SAObjects.framework/SAObjects 
[380] 73F31E86-B0B5-36A2-8A25-D3981BD684E4 0x0000000127d34000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SiriInstrumentation.framework/SiriInstrumentation 
[381] 94122E3B-0E29-3E35-95A4-643DE10AC2BB 0x0000000127e31000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AccessibilityUI.framework/AccessibilityUI 
[382] 0C711A8E-1346-31FE-9C3D-0178B4F0BCCB 0x0000000127e45000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AccessibilityUIShared.framework/AccessibilityUIShared 
[383] F2B8D4DE-B351-3AB0-A6F2-C9AE61B4228A 0x0000000127e55000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/TelephonyUtilities.framework/TelephonyUtilities 
[384] E11333CB-FA57-33C3-AEEB-91B218C8742B 0x0000000128024000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CallHistory.framework/CallHistory 
[385] D88BEDA3-62CF-3598-95D2-F1AE53583BBC 0x00000001280c8000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/HearingCore.framework/HearingCore 
[386] AF43B6A3-7FBD-3A1B-B8CD-7525C02BA65B 0x00000001280e4000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AVConference.framework/AVConference 
[387] 470AB4EC-02C7-3F24-AA12-4DD67C405B2A 0x000000012885e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreDuetContext.framework/CoreDuetContext 
[388] 8A06909C-AFD1-3E64-95CA-77C24B28D2FD 0x000000012890d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IncomingCallFilter.framework/IncomingCallFilter 
[389] 22E09639-3E72-3B7A-806D-510BB1427327 0x000000012891c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/WirelessDiagnostics.framework/WirelessDiagnostics 
[390] 28879F5F-8127-3F8F-BF06-F66A797ED7DE 0x0000000128998000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libAWDSupportFramework.dylib 
[391] E04CB31E-FE4B-3776-9712-0100BB87E1EA 0x0000000128c04000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AVConference.framework/Frameworks/ICE.framework/ICE 
[392] CF170CB6-787A-32A7-BBFE-6906C0FAD667 0x0000000128c58000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AVConference.framework/Frameworks/LegacyHandle.framework/LegacyHandle 
[393] 961BE9BF-F7A6-3F89-A8B3-D7CF612F580E 0x0000000128c61000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AVConference.framework/Frameworks/SimpleKeyExchange.framework/SimpleKeyExchange 
[394] D90B4A28-FB22-36E3-B42D-DE3653519A48 0x0000000128c73000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AVConference.framework/Frameworks/snatmap.framework/snatmap 
[395] 00068ED6-CBD7-3980-A4A4-A20E044B6620 0x0000000128c7b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AVConference.framework/Frameworks/ViceroyTrace.framework/ViceroyTrace 
[396] EB54F7F4-7605-35A1-8B9A-2BD63F4638B1 0x0000000128d1d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FTServices.framework/FTServices 
[397] 4D95B447-7966-3F23-B44E-63B9A89C769F 0x0000000128d97000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FTAWD.framework/FTAWD 
[398] FFC957D6-EB20-3AC1-BCEC-0F2539ED098C 0x0000000128d9f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/NaturalLanguage.framework/NaturalLanguage 
[399] D122DC28-5AF0-3F2C-9DF0-0AFB97A3BC61 0x0000000128e23000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AXAssetLoader.framework/AXAssetLoader 
[400] 696DC8D1-9AE8-3638-80F6-41A4F87735E0 0x0000000128e51000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ProofReader.framework/ProofReader 
[401] D9EF0892-C5F3-34E3-A2BF-C6CE85B25FE0 0x0000000128f8c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/WebKit.framework/WebKit 
[402] 4140A0AB-896E-3BE6-A375-B405D0FE5961 0x0000000129efa000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CorePrediction.framework/CorePrediction 
[403] FC3B7688-465A-3458-98C6-2D52ED911D0B 0x0000000129f80000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/PDFKit.framework/PDFKit 
[404] 285C53D4-598F-3F65-8906-9B36BEDF4544 0x000000012a120000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SafariSafeBrowsing.framework/SafariSafeBrowsing 
[405] F1E08EE3-2606-36BB-B06A-B9D5F4EB3BB2 0x000000012a1c8000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreOptimization.framework/CoreOptimization 
[406] 6AF00D20-107D-30F6-AEAA-54298D2D8DD1 0x000000012a1d6000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CorePDF.framework/CorePDF 
[407] 5BB06C60-C3DF-313C-B415-26AF9E3B0B83 0x000000012a340000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/RevealCore.framework/RevealCore 
[408] 93E56C7C-8854-32CA-801E-1D64267C278C 0x000000012a350000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CTCarrierSpace.framework/CTCarrierSpace 
[409] E20BAA68-D321-365A-9344-4B36D7F61A75 0x000000012a38e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AvatarKit.framework/AvatarKit 
[410] 15F15891-0C2B-3905-80A9-E6B2247A69B8 0x000000012a5d2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AvatarUI.framework/AvatarUI 
[411] 2BBB188F-5593-3BD9-970E-3FEFE9B746C4 0x000000012a8ab000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Messages.framework/Messages 
[412] 63D24A8B-19ED-3EBA-BABA-48417D4896B2 0x000000012a908000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/AVKit.framework/AVKit 
[413] 2F999AB4-CC92-3406-A76B-26A1BF77795E 0x000000012ab51000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ChatKit.framework/ChatKit 
[414] 4C9DA357-8214-35BF-AC9B-D611BD4245CD 0x000000012b6cf000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IMSharedUtilities.framework/IMSharedUtilities 
[415] 36E1451D-76AA-3FEB-8186-127FD21B5D08 0x000000012b838000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/LinkPresentation.framework/LinkPresentation 
[416] 58FDBA25-BE58-3119-B07E-A9FAE40F6E38 0x000000012ba3c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/AddressBook.framework/AddressBook 
[417] 9F60DC11-0853-3414-8519-4A267F642BA1 0x000000012ba9a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/EmojiKit.framework/EmojiKit 
[418] 9E4355E9-F250-3276-9BF8-A2726C02F3FB 0x000000012bab5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Photos.framework/Photos 
[419] 7B725BAA-DDDB-38A2-996A-FFAB21AED3DE 0x000000012bf51000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CameraKit.framework/CameraKit 
[420] B0E3618F-C75E-34F0-BDCD-ECE793EDD3EA 0x000000012bf60000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/StorageSettings.framework/StorageSettings 
[421] F99FAD87-97E8-3837-A53A-24C12C5061E5 0x000000012bfa1000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SiriActivation.framework/SiriActivation 
[422] D509EAC1-94C0-3952-9128-1D7543B4ACB3 0x000000012c038000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CarPlay.framework/CarPlay 
[423] D64F4920-4EB9-3D6F-B42D-3C2077490578 0x000000012c0e3000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/TipKit.framework/TipKit 
[424] E013D79B-FCDD-3990-9C5B-43DB1D9D8719 0x000000012c115000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ToneLibrary.framework/ToneLibrary 
[425] 7F90CFF8-3F89-3BDC-8DE6-6A1917F07F1D 0x000000012c1cc000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/QuickLook.framework/QuickLook 
[426] 242ECDAC-D180-3738-9B43-CF7F1BFF51CE 0x000000012c399000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PhotosFormats.framework/PhotosFormats 
[427] 038FD283-5688-3F57-ABC8-0E8825EF4575 0x000000012c491000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PhotosPlayer.framework/PhotosPlayer 
[428] 7F791D78-B934-3EFB-B6A7-5FF725F80971 0x000000012c52a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ContactsAutocompleteUI.framework/ContactsAutocompleteUI 
[429] F61AF544-33DF-3410-A0D4-7584D1412C59 0x000000012c5e2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PeopleSuggester.framework/PeopleSuggester 
[430] C91CFEE6-568C-38E2-80B3-E66C32123601 0x000000012c6dd000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IMTranscoding.framework/IMTranscoding 
[431] ECD48C64-1ABA-3CAE-82EC-3CBA9A5A9F95 0x000000012c6f3000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IMSharedUI.framework/IMSharedUI 
[432] FECCD73E-4B12-3978-8F06-121E9377E162 0x000000012c72e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IMDPersistence.framework/IMDPersistence 
[433] C8A579DF-C41A-3471-9E81-7D45A7026A08 0x000000012c8b6000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MessageUI.framework/MessageUI 
[434] 76E9742F-88E1-3493-913A-5C94EED6A731 0x000000012cb6c000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IMCore.framework/IMCore 
[435] 5B36B2E6-D415-3259-B146-4CF3B93B87E4 0x000000012cdc7000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FTClientServices.framework/FTClientServices 
[436] C294E607-C83F-35B5-B5E6-71CF51B2AA72 0x000000012cdd4000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MediaConversionService.framework/MediaConversionService 
[437] 2B15E44A-DE5D-396D-82A5-28EAB3ED52C5 0x000000012ce53000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CPAnalytics.framework/CPAnalytics 
[438] 1BCFB152-5449-3E4A-B2A5-21CEFFE59703 0x000000012cea1000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CloudPhotoServices.framework/CloudPhotoServices 
[439] 0A2976F6-C292-3C67-B656-A4FED9BBAEA3 0x000000012cebc000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/ImageCaptureCore.framework/ImageCaptureCore 
[440] ED683090-8034-3A0B-940C-09A11B3112A6 0x000000012cf2b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PhotosImagingFoundation.framework/PhotosImagingFoundation 
[441] 2215C78F-2934-3E93-B41C-97E98B106FE3 0x000000012cfe6000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PhotoFoundation.framework/PhotoFoundation 
[442] 0B4338FA-46A3-3738-9B38-48A1B4BE2A42 0x000000012d0e0000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CloudPhotoLibrary.framework/CloudPhotoLibrary 
[443] 0FD538DF-7254-3429-8088-A397C14B161D 0x000000012d3b2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DCIMServices.framework/DCIMServices 
[444] 4EA07A8E-8F6C-34BB-AF8D-21EA369E02FC 0x000000012d3d9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreMediaStream.framework/CoreMediaStream 
[445] 395C852B-B3A8-332E-852C-4DE7E2C915C4 0x000000012d5af000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PhotoLibraryServices.framework/PhotoLibraryServices 
[446] 5B9A20E8-565E-3323-8567-BEA8260639E8 0x000000012e267000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AssetsLibraryServices.framework/AssetsLibraryServices 
[447] 371BAC2E-1835-3BF6-AFAA-E11184F3EFE6 0x000000012e3f6000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MMCS.framework/MMCS 
[448] 203FE67F-8BB4-3DC9-8ACD-5F8D618DFA3E 0x000000012e516000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CacheDelete.framework/CacheDelete 
[449] 05C14EA6-E548-38BC-BB30-796C56A34F65 0x000000012e562000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AssetCacheServices.framework/AssetCacheServices 
[450] 109E9BB3-5577-306A-8FE1-BA5DEB251E07 0x000000012e5b1000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FSEvents.framework/FSEvents 
[451] A0E0A8F7-262B-30FD-8CAA-EF7E46EAEA0D 0x000000012e5c5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MediaStream.framework/MediaStream 
[452] 0226EE89-D44C-3B3A-9A6A-F065FB009753 0x000000012e60f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/BulletinBoard.framework/BulletinBoard 
[453] BFDC9063-D62A-3D7C-B3AC-0E12630D545A 0x000000012e738000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SiriUICore.framework/SiriUICore 
[454] 429FE9CC-6715-3AD7-9CF3-FCEEF5FDEBB7 0x000000012e7fe000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/IntentsUI.framework/IntentsUI 
[455] 42A3B548-B39E-3E46-B45B-B80263C48310 0x000000012e842000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CarKit.framework/CarKit 
[456] 0198C1ED-7C18-3144-AC5F-AA43EEBF2DE3 0x000000012e8d4000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CallKit.framework/CallKit 
[457] EF1BC482-3387-30BE-A5C8-46A2CD784976 0x000000012e9c8000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FindMyDevice.framework/FindMyDevice 
[458] 9BD76E2A-B8D4-3443-8457-0BF4081C198D 0x000000012ea04000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/FMCoreLite.framework/FMCoreLite 
[459] E8682024-0665-33EF-B441-E690D20D6249 0x000000012ea47000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CarPlayUIServices.framework/CarPlayUIServices 
[460] BFC31A83-C9BC-39AE-92A0-F7A3A4135C6C 0x000000012ea76000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/TipsCore.framework/TipsCore 
[461] 6326F836-522D-3DD4-B73E-3AB83F4BED26 0x000000012eb65000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/TipsUI.framework/TipsUI 
[462] A0A34A1C-CA79-3A05-A523-6ECF98F403D8 0x000000012eb91000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ChronoServices.framework/ChronoServices 
[463] D5CAF43B-268D-364A-8730-91591E6A6F24 0x000000012ebd1000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/PersonalizationPortrait.framework/PersonalizationPortrait 
[464] EF5E88ED-B007-32F5-BFD5-82F10EEC08C6 0x000000012ecc9000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Categories.framework/Categories 
[465] 7E496C67-C98C-340D-A164-4E726CA8F23D 0x000000012ecf4000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DeviceManagement.framework/DeviceManagement 
[466] 323BD491-20A9-3601-B73E-27374AE68B03 0x000000012ede2000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/QuickLookSupport.framework/QuickLookSupport 
[467] 5B533ADF-8D4D-3F11-B24C-B2E116D577D7 0x000000012ee18000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/MediaPlayer.framework/MediaPlayer 
[468] ECE2A6AE-65B5-3247-A9D8-9E6F9BE6E39A 0x000000012f642000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ContextKit.framework/ContextKit 
[469] E8CDEF3A-0211-360F-91A6-D94631A2ED06 0x000000012f671000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ContextKitExtraction.framework/ContextKitExtraction 
[470] 095D5AFD-4516-3357-91D1-087055030A4F 0x000000012f68e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Catalyst.framework/Catalyst 
[471] 8BBA9B92-0550-31B7-B06B-2E626D8C3F95 0x000000012f71b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/HomeSharing.framework/HomeSharing 
[472] C12FADAD-E60B-39B9-9538-E69C176CDD11 0x000000012f78b000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MediaLibraryCore.framework/MediaLibraryCore 
[473] 2DFBC8F4-99F2-3C40-A63C-740EC70ED6BC 0x000000012fd8d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MediaPlatform.framework/MediaPlatform 
[474] 2061D03C-A035-3DF3-9641-D3A0142612B8 0x000000012fedf000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MusicLibrary.framework/MusicLibrary 
[475] C54D2D5F-73DF-3AE1-A731-863B2BB2FD4F 0x0000000130332000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/iTunesCloud.framework/iTunesCloud 
[476] 5EFA6DDA-DBE7-387F-9CA9-5FEBB3BD26E8 0x00000001306d5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DAAPKit.framework/DAAPKit 
[477] 1CD5A92B-ED46-381F-B115-2D93B51D6DEA 0x00000001306e5000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Pegasus.framework/Pegasus 
[478] E660A9F5-E0E3-3828-9539-CB247AD53BAD 0x000000013078e000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MaterialKit.framework/MaterialKit 
[479] 9BD8EEB3-DC80-306B-BC26-C2B6099E6847 0x00000001307c6000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/BaseBoardUI.framework/BaseBoardUI 
[480] 4B57643E-3B44-3836-AD49-6A06F78AC84B 0x00000001307fd000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Email.framework/Email 
[481] 85E6AE83-E3BC-379E-9552-C528B801261E 0x000000013096d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/EmailAddressing.framework/EmailAddressing 
[482] 4FB03302-DDCE-3DF9-AD6D-D54FDFD7CD68 0x0000000130988000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/ContactsAutocomplete.framework/ContactsAutocomplete 
[483] A8217A9A-C632-38E2-90C8-F63512A38B79 0x0000000130a2d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MIME.framework/MIME 
[484] 8885D1BF-901E-3534-9C49-49AD86E0A115 0x0000000130ad0000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/EmailCore.framework/EmailCore 
[485] ED6EE879-FCC1-3231-A15D-F260A2E4A53E 0x0000000130bac000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/EmailFoundation.framework/EmailFoundation 
[486] F519562C-E1F8-3D6E-B6C0-3AA9278FAE02 0x0000000130cbc000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/GSS.framework/GSS 
[487] 64CEB5E8-176B-3CBA-95D9-E061ABD2175B 0x0000000130d12000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Heimdal.framework/Heimdal 
[488] C603CD85-B30F-31C3-B329-EC9B5C9337C1 0x0000000130dc1000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CommonAuth.framework/CommonAuth 
[489] 1DC84618-111A-3C11-8272-739F10A8A5DF 0x0000000130dd3000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MessageSupport.framework/MessageSupport 
[490] 719CDB00-1AC2-3C6B-A0F1-2835039CB198 0x0000000130ddf000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreSDB.framework/CoreSDB 
[491] 99CB7282-67CF-34AB-BDB5-9B1FEBF1EBFB 0x0000000130e03000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/IDSKVStore.framework/IDSKVStore 
[492] B9FCDC75-349B-35D5-AC9C-BFEB5D91C2D1 0x0000000130e14000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/VisionKit.framework/VisionKit 
[493] 5E59EAB9-9601-332C-9667-40DAD2F25918 0x0000000130e1a000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MailServices.framework/MailServices 
[494] B501ABF1-ACF3-3E0A-B5B8-405C6E0C3489 0x0000000130e54000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Message.framework/Message 
[495] F9B7C78D-5BCF-3C4A-94BB-66AF98E5B39F 0x000000013121f000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/PencilKit.framework/PencilKit 
[496] D1B6F234-3C45-3FE3-A3D7-83FBE96ABBDD 0x00000001317f3000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DoNotDisturb.framework/DoNotDisturb 
[497] 6FE1ED2C-CFE9-3FC9-8FA8-C13CA7A62980 0x000000013183d000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/MailSupport.framework/MailSupport 
[498] B421AB97-0F44-3A43-933A-C92722233DF7 0x00000001318ab000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DocumentCamera.framework/DocumentCamera 
[499] 2615AB5E-81EC-349E-9C68-D8741AFB0AB4 0x0000000131a55000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Vision.framework/Vision 
[500] EF7848D1-2642-3585-BFCB-82205C7C77E2 0x0000000131f50000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Vision.framework/libfaceCore.dylib 
[501] 9184ABC9-A94D-3D26-B192-75E2F1294DC4 0x0000000132bec000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Futhark.framework/Futhark 
[502] 4D492767-B1CF-337B-8E1D-2E8A750D767A 0x0000000132c13000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/TextRecognition.framework/TextRecognition 
[503] 8B49027C-1762-3D87-9322-37F1D7DCCB9C 0x0000000132dfc000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CVNLP.framework/CVNLP 
[504] 8A9AD050-819F-3C9B-B5EC-3466F32D8753 0x0000000132eaf000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CertUI.framework/CertUI 
[505] 55F47043-0EA2-3883-9446-813168E5955F 0x0000000132ec7000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DataAccess.framework/DataAccess 
[506] 93571980-06AD-3B7A-8276-D1CDA4247018 0x0000000132f88000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/EmailDaemon.framework/EmailDaemon 
[507] 4EF60B41-6BDC-33F2-9A9D-CC0DABCF04E6 0x00000001332f0000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/Notes.framework/Notes 
[508] B115A500-4587-34B4-85DE-FEA0D1DBC7F0 0x0000000133397000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreHandwriting.framework/CoreHandwriting 
[509] 3A2032CA-2178-3C0A-8E4A-FAB75B3123F5 0x00000001335bb000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libmecabra.dylib 
[510] 7092FC73-3268-3D35-9DDE-65EE8C5AF5A6 0x00000001338b0000 /Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/CoreServicesInternal.framework/CoreServicesInternal 
(lldb) 
```

9. cmd + k
清除console内容