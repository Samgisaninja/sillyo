%hook URLManager
// THX sbingner!
+(NSMutableURLRequest*) urlRequestWithHeaders:(NSURL *)url includingDeviceInfo:(bool)info {
    NSMutableURLRequest *req = %orig;
    if ([req valueForHTTPHeaderField:@"X-Firmware"] == nil){
        [req setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"X-Firmware"];
    }
    return req;
}

%end

%hook APTWrapper

+(NSString*)getOutputForArguments:(NSArray*)arguments errorOutput:(NSString**)errorOutput error:(NSError**)error {
    NSMutableArray *newargs = [arguments mutableCopy];
    [newargs removeObject:@"-oAPT::Format::for-sileo=true"];
    NSString *output = %orig(newargs, errorOutput, error);
    NSRegularExpression *instExpr = [NSRegularExpression regularExpressionWithPattern:@"^(\\S+) (\\S+) \\((\\S+) (.+\\])\\)$"
                                                            options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSRegularExpression *reinstExpr = [NSRegularExpression regularExpressionWithPattern:@"^(\\S+) (\\S+) \\[(\\S+)\\] \\((\\S+) (.+\\])\\)$"
                                                            options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSRegularExpression *removeExpr = [NSRegularExpression regularExpressionWithPattern:@"^(\\S+) (\\S+) \\[(\\S+)\\]$"
                                                            options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSMutableArray <NSString*> *outputs = [NSMutableArray new];
    for (NSTextCheckingResult *line in [instExpr matchesInString:output options:0 range:NSMakeRange(0, output.length)]) {
        NSString *json = [[NSString alloc]
            initWithData:[NSJSONSerialization dataWithJSONObject:@{
                @"Type": [output substringWithRange:[line rangeAtIndex:1]],
                @"Package": [output substringWithRange:[line rangeAtIndex:2]],
                @"Version": [output substringWithRange:[line rangeAtIndex:3]],
                @"Release": [output substringWithRange:[line rangeAtIndex:4]]
            } options:0 error:nil] encoding:NSUTF8StringEncoding];
        [outputs addObject:json];
        [json release];
    }
    for (NSTextCheckingResult *line in [reinstExpr matchesInString:output options:0 range:NSMakeRange(0, output.length)]) {
        NSString *json = [[NSString alloc]
            initWithData:[NSJSONSerialization dataWithJSONObject:@{
                @"Type": [output substringWithRange:[line rangeAtIndex:1]],
                @"Package": [output substringWithRange:[line rangeAtIndex:2]],
                @"Version": [output substringWithRange:[line rangeAtIndex:4]],
                @"Release": [output substringWithRange:[line rangeAtIndex:5]]
            } options:0 error:nil] encoding:NSUTF8StringEncoding];
        [outputs addObject:json];
        [json release];
    }
    for (NSTextCheckingResult *line in [removeExpr matchesInString:output options:0 range:NSMakeRange(0, output.length)]) {
        NSString *json = [[NSString alloc]
            initWithData:[NSJSONSerialization dataWithJSONObject:@{
                @"Type": [output substringWithRange:[line rangeAtIndex:1]],
                @"Package": [output substringWithRange:[line rangeAtIndex:2]],
                @"Version": [output substringWithRange:[line rangeAtIndex:3]]
            } options:0 error:nil] encoding:NSUTF8StringEncoding];
        [outputs addObject:json];
        [json release];
    }

    NSString *newOutput = [outputs componentsJoinedByString:@"\n"];

    NSLog(@"Sillyo: %@", newOutput);
    return [newOutput retain];
}

%end

%hook __NSCFString
-(BOOL)isEqualToString:(NSString*)string {
    if (string && (strcmp(string.UTF8String, "cydia.list")==0 || strcmp(string.UTF8String, "saurik.list")==0)) {
        return NO;
    }
    return %orig;
}

%end
//Special thanks to the ocean team!
@import WebKit;

%hook WKWebView
-(id)initWithFrame:(CGRect)arg1 configuration:(WKWebViewConfiguration*)config {
    config.preferences.javaScriptEnabled = YES;
    return %orig;
}

-(WKWebViewConfiguration*)configuration {
    WKWebViewConfiguration* config = %orig;
    config.preferences.javaScriptEnabled = YES;
    return config;
}
%end
