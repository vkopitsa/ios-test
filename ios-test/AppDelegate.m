//
//  AppDelegate.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 11/23/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "AppDelegate.h"
#import "ShopViewController.h"
#import "APIAuth.h"
#import "Reachability.h"
#import "CartViewControl.h"

@interface AppDelegate ()

@property (nonatomic, strong) CartViewControl *cart;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL authenticatedUser = [[APIAuth sharedManager] isAuthorization];
    
    UIViewController *initialViewController = nil;
    
    
    if (authenticatedUser) {
        UIStoryboard *loginRegistation = [UIStoryboard storyboardWithName:@"Shop" bundle:nil];
        
        // Instantiate the initial view controller object from the storyboard
        initialViewController = [loginRegistation instantiateInitialViewController];
        //initialViewController = [loginRegistation instantiateViewControllerWithIdentifier:@"shop"];
        
    }else{
        UIStoryboard *loginRegistation = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        
        // Instantiate the initial view controller object from the storyboard
        initialViewController = [loginRegistation instantiateInitialViewController];
    }
    
    
    // Instantiate a UIWindow object and initialize it with the screen size of the iOS device
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Set the initial view controller to be the root view controller of the window object
    self.window.rootViewController  = initialViewController;
    
    // Set the window object to be the key window and show it
    [self.window makeKeyAndVisible];
    
    [self isConnection];
    
    //[self startCart];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.vkopitsa.ios_test" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ios_test" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ios_test.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"access_token=(\\w*)&" options:0 error:NULL];
    NSString *str = [url absoluteString];
    NSTextCheckingResult *match = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    
    NSLog(@"%@", [str substringWithRange:[match rangeAtIndex:1]]);
    
    
    if ([sourceApplication containsString: @"com.apple.mobilesafari"]) {
        
        UIViewController *initialViewController = nil;
        
        
        UIStoryboard *loginRegistation = [UIStoryboard storyboardWithName:@"Shop" bundle:nil];
        
        // Instantiate the initial view controller object from the storyboard
        //initialViewController = [loginRegistation instantiateViewControllerWithIdentifier:@"shop"];
        initialViewController = [loginRegistation instantiateInitialViewController];

        // Instantiate a UIWindow object and initialize it with the screen size of the iOS device
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        // Set the initial view controller to be the root view controller of the window object
        self.window.rootViewController  = initialViewController;
        
        // Set the window object to be the key window and show it
        [self.window makeKeyAndVisible];
    }


   // self.window.rootViewController = [[UIStoryboard storyboardWithName:@"shop" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"shop"];

    
    return YES;
}

- (void) isConnection {

    // Allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:@"shop-test.of-it.org"];
    
    
    UIView *viewPopup=[[UIView alloc]init];
    [viewPopup setBackgroundColor:[UIColor blackColor]];
    viewPopup.alpha=0.1f;
    [viewPopup setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [viewPopup setCenter:self.window.center];
    
    UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50)];
    [yourLabel setCenter:viewPopup.center];
    yourLabel.textAlignment = NSTextAlignmentCenter;
    [yourLabel setTextColor:[UIColor blackColor]];
    [yourLabel setBackgroundColor:[UIColor redColor]];
    yourLabel.text = @"No internet connection";


    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            viewPopup.hidden = YES;
            yourLabel.hidden = YES;
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            viewPopup.hidden = NO;
            yourLabel.hidden = NO;
            //[self.window bringSubviewToFront:viewPopup];
            [self.window addSubview:viewPopup];
            [self.window bringSubviewToFront:[viewPopup superview]];
            [[viewPopup superview] addSubview:yourLabel];
            [[viewPopup superview] bringSubviewToFront:yourLabel];

        });
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
    
}


- (void) startCart: (NSString *) amount {
    
    
    if (self.cart != nil) {
        self.cart.hidden = NO;
        [[self.window.rootViewController.view superview] bringSubviewToFront:self.cart];
    }else{
        self.cart = [[CartViewControl alloc]initWithFrame:CGRectMake(self.window.rootViewController.view.frame.size.width - 48 - 20.f,
                                                                     self.window.rootViewController.view.frame.size.height - 48 - 60.f,
                                                                     48,
                                                                     48)];
        
        //[[crat superview] bringSubviewToFront:imageView];
        [[self.window.rootViewController.view superview] addSubview:self.cart];
        [[self.window.rootViewController.view superview] bringSubviewToFront:self.cart];
        
        
        self.cart.hidden = NO;
        
        //The setup code (in viewDidLoad in your view controller)
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        [self.cart addGestureRecognizer:singleFingerTap];
    }
    
    [self.cart setText:[NSString stringWithFormat:@"%@", [[CartManager sharedManager] getCountGoodsInCart]]];
    
}

- (void)hideCart{
    NSLog(@"hideCart");
    self.cart.hidden = YES;
}

- (void)showCart{
    NSLog(@"showCart");
    self.cart.hidden = NO;
    [[self.window.rootViewController.view superview] bringSubviewToFront:self.cart];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    NSLog(@"Tap %f %f", location.x, location.y);

    
    //CartCollectionViewController
    
    [self.window.rootViewController performSegueWithIdentifier:@"gocartnew" sender:self];

}

@end
