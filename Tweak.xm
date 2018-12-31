%hook Database

- (NSArray *) sources {
  NSLog(@"%@", %orig);
  return %orig;
}

%end
