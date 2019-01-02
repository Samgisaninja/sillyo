%hook Database

- (NSArray *) sources {
  NSArray *sourcesList = %orig;
  int i;
  NSMutableArray *uniqueSourcesList
    for (i=0; i < [sourcesList count]; i++) {
        NSString *unformattedSource = [sourcesList objectAtIndex:i];
        NSString *unformattedSourceStringAddress = [unformattedSource stringByReplacingOccurrencesOfString:@"<Source: " withString:@""];
        NSString *sourceStringAddress = [unformattedSourceStringAddress stringByReplacingOccurrencesOfString:@">" withString:@""];
        NSString *sourceString;
        sscanf([sourceStringAddress cStringUsingEncoding:NSUTF8StringEncoding], "%p", &sourceString);
        if ([uniqueSourcesList containsObject:sourceList]) {} else {
        [uniqueSourcesList addObject:sourceString];
        }
    }
  return %orig;
}

%end
