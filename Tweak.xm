%group cydia

//Part 1: fix duplicate sources error.
@interface Source
- (NSString *) rooturi;
- (void) _remove;
@end

%hook Database

- (NSArray *) sources {
  NSArray *sourcesList = %orig;
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
  return %orig;
}

%end

%end



%group sileo

%hook URLManager
// THX sbingner!
+(NSMutableURLRequest*) urlRequestWithHeaders:(NSURL *)url includingDeviceInfo:(bool)info {
   NSMutableURLRequest *req = %orig;
  if ([req valueForHTTPHeaderField:@"X-Firmware"] == nil){
    [req setValue:[NSString stringWithFormat:@"%0.1f", [[[UIDevice currentDevice] systemVersion] floatValue]] forHTTPHeaderField:@"X-Firmware"];
  }
  return req;
}

%end

%end

%ctor {
	if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.saurik.Cydia"]) {
		%init(cydia);
	} else if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"org.coolstar.SileoStore"]) {
		%init(sileo);
	}
}
