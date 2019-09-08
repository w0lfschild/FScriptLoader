//
//  FScriptLoader.m
//  FScriptLoader
//
//  Created by Wolfgang Baird on 2/4/18.
//Copyright © 2018 Wolfgang Baird. All rights reserved.
//

@import AppKit;

@interface FScriptMenuItem : NSMenuItem

- (IBAction)openObjectBrowser:(id)sender;
- (IBAction)showConsole:(id)sender;
- (IBAction)showPreferencePanel:(id)sender;
- (IBAction)updatePreference:(id)sender;
- (void)insertInMainMenu;

@end

@interface FScriptLoader : NSObject {
    id eventMonitor;
    NSMenuItem* menuItem;
}

+(void) load;
+(FScriptLoader*) sharedInstance;
@end

@implementation FScriptLoader

+ (instancetype)sharedInstance{
    static FScriptLoader *plugin = nil;
    @synchronized(self) {
        if (!plugin) {
            plugin = [[self alloc] init];
        }
    }
    return plugin;
}

+ (void)load {
    NSLog(@"fscriptloader : %@", NSBundle.mainBundle.bundleIdentifier);
    NSArray *blackList = [[NSArray alloc] initWithObjects:@"com.apple.dock", @"com.apple.loginwindow", nil];
    NSUInteger osx_ver = [[NSProcessInfo processInfo] operatingSystemVersion].minorVersion;
    if (![blackList containsObject:NSBundle.mainBundle.bundleIdentifier]) {
        // Load F-Script
        NSString *FScript = [NSString stringWithFormat:@"%@/Contents/Frameworks/FScript.framework", [[NSBundle bundleWithIdentifier:@"org.w0lf.FScriptLoader"] bundlePath]];
        [[NSBundle bundleWithPath:FScript] load];
        
        // Setup keywatch
        FScriptLoader* plugin = [FScriptLoader sharedInstance];
        
        // Add menuitem into main menu
        [NSClassFromString(@"FScriptMenuItem") performSelector:@selector(insertInMainMenu)];
        
        // Log
        
        NSLog(@"%@ loaded into %@ on macOS 10.%ld", [self class], [[NSBundle mainBundle] bundleIdentifier], (long)osx_ver);
    } else {
        NSLog(@"%@ aborted loading into %@ on macOS 10.%ld", [self class], [[NSBundle mainBundle] bundleIdentifier], (long)osx_ver);
    }
}

-(id) init {
    self = [super init];
    if( !self ) return nil;
    menuItem = [NSClassFromString(@"FScriptMenuItem").alloc init];

    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask
                                           handler:^(NSEvent *event){
                                               if ([event modifierFlags] == 1704234 && [event keyCode] == 8) {
                                                   /*CMD, ALT, SHIFT + C*/
                                                   [menuItem performSelector:@selector(showConsole:) withObject:nil];
                                               } else if ([event modifierFlags] == 1704234 && [event keyCode] == 31) {
                                                   [menuItem performSelector:@selector(openObjectBrowser:) withObject:nil];
                                               }
                                           }];
    
    NSEvent * (^monitorHandler)(NSEvent *);
    monitorHandler = ^NSEvent * (NSEvent * event){
        if ([event modifierFlags] == 1704234 && [event keyCode] == 8) {
            /*CMD, ALT, SHIFT + C*/
            [menuItem performSelector:@selector(showConsole:) withObject:nil];
            return nil;
        } else if ([event modifierFlags] == 1704234 && [event keyCode] == 31) {
            [menuItem performSelector:@selector(openObjectBrowser:) withObject:nil];
            return nil;
        }
        // Return the event, a new event, or, to stop
        // the event from being dispatched, nil
        return event;
    };
    
    eventMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask
                                                         handler:monitorHandler];
    return self;
}

@end
