@interface Source
- (NSString *) rooturi;
@end

%hook Database

- (NSArray *) sources {
  NSArray *sourcesList = %orig;
  for(Source * checkingSource in sourcesList)
  {
    NSLog(@"%@", [checkingSource rooturi]);
  }
  return sourcesList;
}

%end
