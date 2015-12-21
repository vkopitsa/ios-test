//
//  GoodsAdminTableViewController.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/6/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "GoodsAdminTableViewController.h"
#import "APIAuth.h"

@interface GoodsAdminTableViewController ()

@property (nonatomic, strong) NSMutableArray * goods;

@end

@implementation GoodsAdminTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [[APIManager sharedManager] getGoods:(NSInteger *) 10 skip:(NSInteger *) 10 success:^(NSMutableArray *goods) {
        
        @autoreleasepool {
            
            NSMutableArray * goods1 = [[NSMutableArray alloc] init];
            for (NSDictionary *item in goods) {
                //                GoodsModel * goods1 = [[GoodsModel alloc] initWithDictionary:item];
                [goods1 addObject:[[GoodsModel alloc] initWithDictionary:item]];
            }
            
            self.goods = goods1;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        
        
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    
    
    // Initialize Refresh Control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    // Configure Refresh Control
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    // Configure View Controller
    [self setRefreshControl:refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.goods count];
}

- (void)refresh:(id)sender
{
    NSLog(@"Refreshing");
    
    [[APIManager sharedManager] getGoods:(NSInteger *) 10 skip:(NSInteger *) 10 success:^(NSMutableArray *goods) {
        
        @autoreleasepool {
            
            NSMutableArray * goods1 = [[NSMutableArray alloc] init];
            for (NSDictionary *item in goods) {
                //                GoodsModel * goods1 = [[GoodsModel alloc] initWithDictionary:item];
                [goods1 addObject:[[GoodsModel alloc] initWithDictionary:item]];
            }
            
            self.goods = goods1;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                // End Refreshing
                [(UIRefreshControl *)sender endRefreshing];
            });
        }
        
        
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            // End Refreshing
            [(UIRefreshControl *)sender endRefreshing];
        });
        
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsAdminCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsAdminCellTableViewCell"];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"GoodsAdminCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"GoodsAdminCellTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsAdminCellTableViewCell"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(GoodsAdminCellTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsModel * message = [self.goods objectAtIndex:indexPath.row];
    cell.name.text = message.name;
    cell.price.text = [NSString stringWithFormat:@"%@, USD", message.price];
    cell.count.text = [NSString stringWithFormat:@"%@", message.count];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self deleteGoogs:indexPath];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"goedit"]) {
        
        GoodsUpdateViewController *goodsViewController = [segue destinationViewController];
        GoodsModel * goods = [self.goods objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        goodsViewController.goods = goods;
        goodsViewController.title = goods.name;
    }
    
    if ([[segue identifier] isEqualToString:@"goadd"]) {
        
        NSDictionary *dictionary = @{
                                     @"name": @"",
                                     @"count": @0,
                                     @"price": @0
                                     };
        
        
        GoodsUpdateViewController *goodsViewController = [segue destinationViewController];
        GoodsModel * goods = [[GoodsModel alloc] initWithDictionary:dictionary];
        goodsViewController.goods = goods;
        goodsViewController.title = goods.name;
        
        goodsViewController.goodsList = self.goods;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"goedit" sender:self];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate hideCart];

}

- (IBAction)logout:(id)sender {
    [[APIAuth sharedManager] logout];
    
    UIViewController *initialViewController = nil;
    
    UIStoryboard *loginRegistation = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    
    // Instantiate the initial view controller object from the storyboard
    //initialViewController = [loginRegistation instantiateViewControllerWithIdentifier:@"shop"];
    initialViewController = [loginRegistation instantiateInitialViewController];
    
    UIWindow *mWindow = self.view.window;
    
    for (UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    
    [mWindow setRootViewController:initialViewController];
    [mWindow makeKeyAndVisible];

}

-(void) deleteGoogs:(NSIndexPath *) indexPath
{
    GoodsModel * goods = [self.goods objectAtIndex:indexPath.row];
    
    
    
    
//    InboxListRequestModel *requestModel = [InboxListRequestModel new];
//    
//    [[APIManager sharedManager] removeInbox:requestModel inbox:inbox.id success:^(NSDictionary *responseModel) {
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            @autoreleasepool {
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.inboxes removeObjectAtIndex:indexPath.row];
//                    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//                    
//                });
//            }
//        });
//        
//    } failure:^(NSError *error) {
//        [self.tableView reloadData];
//    }];
    
    [[APIManager sharedManager] removeGoods:goods success:^(NSMutableArray * data){
        
        NSLog(@"success");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.goods removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        });
        
    } failure:^(NSError *error) {
        NSLog(@"failure");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    
}


@end
