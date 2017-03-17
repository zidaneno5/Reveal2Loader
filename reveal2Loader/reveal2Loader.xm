
#include <dlfcn.h>
%ctor {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSDictionary *prefs = [[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.rheard.RHRevealLoader.plist"] retain];
    NSString *libraryPath = @"/Library/Frameworks/RevealServer.framework/RevealServer";
    
    if([[prefs objectForKey:[NSString stringWithFormat:@"RHRevealEnabled-%@", [[NSBundle mainBundle] bundleIdentifier]]] boolValue]) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:libraryPath]){
            dlopen([libraryPath UTF8String], RTLD_NOW);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"IBARevealRequestStart" object:nil];
            NSLog(@"Reveal2Loader loaded %@", libraryPath);
        }
    }
    
    [pool drain];
}

