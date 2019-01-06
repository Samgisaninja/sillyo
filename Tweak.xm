//Part 1: fix duplicate sources error.
@interface Source
- (NSString *) rooturi;
- (void) _remove;
@end

%hook Database

- (NSArray *) sources {
  if ([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt/sources.list.d/sileo.sources"]) {
    NSArray *sourcesList = %orig;
    BOOL didRemoveSource;
    NSMutableArray *removedSources = [[NSMutableArray alloc] init];
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
              didRemoveSource = TRUE;
              [removedSources addObject:[checkingSource rooturi]];
              [checkingSource _remove];
            }
        }
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt/sources.list.d/sileo.list"]) {
      NSArray *sourcesList = %orig;
      BOOL didRemoveSource;
      NSMutableArray *removedSources = [[NSMutableArray alloc] init];
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
                didRemoveSource = TRUE;
                [removedSources addObject:[checkingSource rooturi]];
                [checkingSource _remove];
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
  }
  return %orig;
}

%end
