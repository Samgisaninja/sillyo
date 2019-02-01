@import WebKit;

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

@interface Repo : NSObject
@property (nonatomic, retain) NSString* rawURL;
@end

@interface RepoManager : NSObject
+(instancetype)sharedInstance;
@end

BOOL repoInstalled(NSString* cmd) {
    NSArray<NSString*>* comp = [cmd componentsSeparatedByString:@"rm \'/var/lib/apt/lists/"];
    if (comp.count > 1) {
        NSString* repo = [comp[1] componentsSeparatedByString:@"_._"][0];
        if (repo.length) {
            if ([repo containsString:@"apt.thebigboss.org"]) return YES;
            NSArray<Repo*>* repoList = MSHookIvar<NSArray<Repo*>*>([%c(RepoManager) sharedInstance], "_repoList");
            for (Repo* r in repoList) {
                NSString* url = r.rawURL;
                comp = [url componentsSeparatedByString:@"://"];
                if (comp.count > 1) {
                    url = comp[1];
                    url = [url stringByReplacingOccurrencesOfString:@"/" withString:@""];
                    if ([repo containsString:url]) return YES;
                }
            }
        }
    }
    return NO;
}

%hook NSConcreteTask
-(void)setArguments:(NSArray*)arguments
{
    NSMutableArray *newargs = [arguments mutableCopy];
    [newargs removeObject:@"-oAPT::Format::for-sileo=true"];
    if (newargs.count) {
        NSString* cmd = newargs[0];
        if ([cmd hasPrefix:@"rm \'/var/lib/apt/lists/"]) {
            if (repoInstalled(cmd)) return;
        }
    }
    %orig(newargs);
}
%end


NSString *makeShittyJSON(NSString* output) {
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
    return [output stringByAppendingString:newOutput];
}

%hook NSConcreteFileHandle

-(NSData*)readDataToEndOfFile
{
    NSData *data = [%orig mutableCopy];
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *shittyJSON = makeShittyJSON(output);
    return [shittyJSON dataUsingEncoding:NSUTF8StringEncoding];
}


%end

//Special thanks to the ocean team!

%hook WKWebView
-(void)layoutSubviews
{
    %orig;
    [self reload];
}
%end

%hook WKPreferences
-(void)setJavaScriptEnabled:(BOOL)arg1
{
    arg1 = YES;
    %orig;
}

-(BOOL)javaScriptEnabled
{
    return YES;
}
%end

//thanks pixelomer!
#pragma mark split sources
%hook NSFileManager

- (id)contentsOfDirectoryAtPath:(NSString*)path error:(NSError**)error {
	return %orig([path stringByReplacingOccurrencesOfString:@"/etc/apt/sources.list.d" withString:@"/etc/apt/sillyo"], error);
}

%end

%hook RepoManager

- (void)parseSourcesFile:(NSString*)file {
	%orig([file stringByReplacingOccurrencesOfString:@"/etc/apt/sources.list.d" withString:@"/etc/apt/sillyo"]);
    NSMutableArray<Repo*>* repos = MSHookIvar<NSMutableArray<Repo*>*>(self, "_repoList");
    for (Repo* r in repos)
    {
        if ([r.rawURL isEqualToString:@"https://electrarepo64.coolstar.org/"])
        {
            [repos removeObject:r];
            break;
        }
    }
}

- (void)parseListFile:(NSString*)file {
	%orig([file stringByReplacingOccurrencesOfString:@"/etc/apt/sources.list.d" withString:@"/etc/apt/sillyo"]);
}

%end

%hook rootMeWrapper

// Sileo uses this function to update the sileo.sources file.
+ (int)outputForCommandAsRoot:(NSString*)cmd output:(id*)out {
	@autoreleasepool {
		NSString *finalCmd = [cmd stringByReplacingOccurrencesOfString:@"/etc/apt/sources.list.d" withString:@"/etc/apt/sillyo"];
		int exitCode = %orig(finalCmd, out);
		return exitCode;
	}
}

%end
#pragma mark end split sources
