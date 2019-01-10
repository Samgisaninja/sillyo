#line 1 "Tweak.xm"

#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class URLManager; @class Database; 


#line 1 "Tweak.xm"
static NSArray * (*_logos_orig$cydia$Database$sources)(_LOGOS_SELF_TYPE_NORMAL Database* _LOGOS_SELF_CONST, SEL); static NSArray * _logos_method$cydia$Database$sources(_LOGOS_SELF_TYPE_NORMAL Database* _LOGOS_SELF_CONST, SEL); 


@interface Source
- (NSString *) rooturi;
- (void) _remove;
@end



static NSArray * _logos_method$cydia$Database$sources(_LOGOS_SELF_TYPE_NORMAL Database* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
  NSArray *sourcesList = _logos_orig$cydia$Database$sources(self, _cmd);
  BOOL didRemoveSource;
  NSMutableArray *removedSources = [[NSMutableArray alloc] init];
  if ([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt/sources.list.d/sileo.sources"]) {
    for(Source *checkingSource in sourcesList) {
      NSMutableString *checkingSourceString = [NSMutableString stringWithString:[checkingSource rooturi]];
      [checkingSourceString replaceOccurrencesOfString:@"https://" withString:@"" options:nil range:NSMakeRange(0, [checkingSourceString length])];
      [checkingSourceString replaceOccurrencesOfString:@"http://" withString:@"" options:nil range:NSMakeRange(0, [checkingSourceString length])];
      NSString *sileoSourcesString = [NSString stringWithContentsOfFile:@"/etc/apt/sources.list.d/sileo.sources" encoding:NSUTF8StringEncoding error:nil];
      NSString *cydiaSourcesString = [NSString stringWithContentsOfFile:@"/etc/apt/sources.list.d/cydia.list" encoding:NSUTF8StringEncoding error:nil];
      if ([sileoSourcesString rangeOfString:checkingSourceString].location == NSNotFound) {}
        else {
          if ([cydiaSourcesString rangeOfString:checkingSourceString].location == NSNotFound) {}
            else {
              if ([[checkingSource rooturi] isEqualToString:@"https://apt.bingner.com"]) {}
                else {
                  didRemoveSource = TRUE;
                  [removedSources addObject:[checkingSource rooturi]];
                  [checkingSource _remove];
              }
            }
        }
    }
  }
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt/sources.list.d/sileo.list"]) {
      for(Source *checkingSource in sourcesList) {
        NSMutableString *checkingSourceString = [NSMutableString stringWithString:[checkingSource rooturi]];
        [checkingSourceString replaceOccurrencesOfString:@"https://" withString:@"" options:nil range:NSMakeRange(0, [checkingSourceString length])];
        [checkingSourceString replaceOccurrencesOfString:@"http://" withString:@"" options:nil range:NSMakeRange(0, [checkingSourceString length])];
        NSString *sileoSourcesString = [NSString stringWithContentsOfFile:@"/etc/apt/sources.list.d/sileo.list" encoding:NSUTF8StringEncoding error:nil];
        NSString *cydiaSourcesString = [NSString stringWithContentsOfFile:@"/etc/apt/sources.list.d/cydia.list" encoding:NSUTF8StringEncoding error:nil];
        if ([sileoSourcesString rangeOfString:checkingSourceString].location == NSNotFound) {}
          else {
            if ([cydiaSourcesString rangeOfString:checkingSourceString].location == NSNotFound) {}
              else {
                if ([[checkingSource rooturi] isEqualToString:@"https://apt.bingner.com"]) {}
                  else {
                    didRemoveSource = TRUE;
                    [removedSources addObject:[checkingSource rooturi]];
                    [checkingSource _remove];
                }
              }
          }
      }
    }
    if (didRemoveSource) {
      #pragma clang diagnostic push
  	  #pragma clang diagnostic ignored "-Wdeprecated-declarations"
  	  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sileo compatibility layer" message:[NSString stringWithFormat:@"Duplicate Sources Error Fixed!\n\nThe following repos were added to both Cydia and Sileo:\n%@\nIf you'd like to remove these repos at a later time, you must do so through Sileo.\n\nPLEASE RESTART CYDIA", [removedSources componentsJoinedByString:@"\n"]] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
  	  [alert show];
  	  [alert release];
      #pragma clang diagnostic pop
    }
  return _logos_orig$cydia$Database$sources(self, _cmd);
}







static NSMutableURLRequest* (*_logos_meta_orig$sileo$URLManager$urlRequestWithHeaders$includingDeviceInfo$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSURL *, bool); static NSMutableURLRequest* _logos_meta_method$sileo$URLManager$urlRequestWithHeaders$includingDeviceInfo$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSURL *, bool); 



static NSMutableURLRequest* _logos_meta_method$sileo$URLManager$urlRequestWithHeaders$includingDeviceInfo$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSURL * url, bool info) {
   NSMutableURLRequest *req = _logos_meta_orig$sileo$URLManager$urlRequestWithHeaders$includingDeviceInfo$(self, _cmd, url, info);
  if ([req valueForHTTPHeaderField:@"X-Firmware"] == nil){
    [req setValue:[NSString stringWithFormat:@"%0.1f", [[[UIDevice currentDevice] systemVersion] floatValue]] forHTTPHeaderField:@"X-Firmware"];
  }
  return req;
}





static __attribute__((constructor)) void _logosLocalCtor_07b3768c(int __unused argc, char __unused **argv, char __unused **envp) {
	if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.saurik.Cydia"]) {
		{Class _logos_class$cydia$Database = objc_getClass("Database"); MSHookMessageEx(_logos_class$cydia$Database, @selector(sources), (IMP)&_logos_method$cydia$Database$sources, (IMP*)&_logos_orig$cydia$Database$sources);}
	} else if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"org.coolstar.SileoStore"]) {
		{Class _logos_class$sileo$URLManager = objc_getClass("URLManager"); Class _logos_metaclass$sileo$URLManager = object_getClass(_logos_class$sileo$URLManager); MSHookMessageEx(_logos_metaclass$sileo$URLManager, @selector(urlRequestWithHeaders:includingDeviceInfo:), (IMP)&_logos_meta_method$sileo$URLManager$urlRequestWithHeaders$includingDeviceInfo$, (IMP*)&_logos_meta_orig$sileo$URLManager$urlRequestWithHeaders$includingDeviceInfo$);}
	}
}
