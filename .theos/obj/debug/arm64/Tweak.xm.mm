#line 1 "Tweak.xm"

@interface Source
- (NSString *) rooturi;
- (void) _remove;
@end


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

@class Database; 
static NSArray * (*_logos_orig$_ungrouped$Database$sources)(_LOGOS_SELF_TYPE_NORMAL Database* _LOGOS_SELF_CONST, SEL); static NSArray * _logos_method$_ungrouped$Database$sources(_LOGOS_SELF_TYPE_NORMAL Database* _LOGOS_SELF_CONST, SEL); 

#line 7 "Tweak.xm"


static NSArray * _logos_method$_ungrouped$Database$sources(_LOGOS_SELF_TYPE_NORMAL Database* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
  NSArray *sourcesList = _logos_orig$_ungrouped$Database$sources(self, _cmd);
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
  	  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sillyo" message:[NSString stringWithFormat:@"Duplicate Sources Error Fixed!\n\nThe following repos were added to both Cydia and Sileo:\n%@\nIf you'd like to remove these repos at a later time, you must do so through Sileo.", [removedSources componentsJoinedByString:@"\n"]] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
  	  [alert show];
  	  [alert release];
      #pragma clang diagnostic pop
    }
  return _logos_orig$_ungrouped$Database$sources(self, _cmd);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$Database = objc_getClass("Database"); MSHookMessageEx(_logos_class$_ungrouped$Database, @selector(sources), (IMP)&_logos_method$_ungrouped$Database$sources, (IMP*)&_logos_orig$_ungrouped$Database$sources);} }
#line 67 "Tweak.xm"
