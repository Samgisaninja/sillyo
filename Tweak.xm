%hook BaseSettingsViewController

-(void)viewDidLoad {
  %orig;
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook CategoryViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"CategoryViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook CydiaAccountViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"CategoryViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook DepictionFormViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"CategoryViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook DepictionScreenshotsViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"CategoryViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook DepictionSubpageViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"CategoryViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook DownloadsTableViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"CategoryViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}


%end

%hook FeaturedViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"FeaturedViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook FlaggedSourceWarningViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"FeaturedViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook InstalledContentsViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"FeaturedViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook InstallViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"FeaturedViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook NewsViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"NewsViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook PackageListViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"FeaturedViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook PackageViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"FeaturedViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook PaymentProfileViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"FeaturedViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end

%hook SettingsViewController

-(void)viewDidLoad {
  %orig;
  NSLog(@"SettingsViewController SAMGISANINJA");
  [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
  [[NSFileManager defaultManager] copyItemAtPath:@"/etc/apt/sources.list.d/sileo.sources" toPath:@"/var/mobile/Library/Caches/sileo.sources" error:nil];
}

%end
