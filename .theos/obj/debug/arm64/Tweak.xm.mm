#line 1 "Tweak.xm"
@interface Source
- (NSString *) rooturi;
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

#line 5 "Tweak.xm"


static NSArray * _logos_method$_ungrouped$Database$sources(_LOGOS_SELF_TYPE_NORMAL Database* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
  NSArray *sourcesList = _logos_orig$_ungrouped$Database$sources(self, _cmd);
  for(Source * checkingSource in sourcesList)
  {
    NSLog(@"%@", [checkingSource rooturi]);
  }
  return sourcesList;
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$Database = objc_getClass("Database"); MSHookMessageEx(_logos_class$_ungrouped$Database, @selector(sources), (IMP)&_logos_method$_ungrouped$Database$sources, (IMP*)&_logos_orig$_ungrouped$Database$sources);} }
#line 17 "Tweak.xm"
