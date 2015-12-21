//
//  CartCollectionViewController.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/13/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "CartCollectionViewController.h"

@interface CartCollectionViewController () {

    NSArray *items;

}

@end

@implementation CartCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //[self.collectionView registerClass:[CartCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // allow multiple selections
    //self.collectionView.allowsMultipleSelection = YES;
    //self.collectionView.allowsSelection = YES;
    
    // Do any additional setup after loading the view.
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate hideCart];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    items = [[CartManager sharedManager] getItemsInCart];
    
    
    //[self.collectionView registerNib:[UINib nibWithNibName:@"GoodsTableViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.allowsMultipleSelection = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//- (id)initWithCollectionView:(UICollectionView *)collectionView
//{
//    self = [super init];
//    
//    if (self)
//    {
//    items = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"egg_benedict.jpg", @"full_breakfast.jpg", @"green_tea.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"starbucks_coffee.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", @"white_chocolate_donut.jpg", nil];
//    }
//    
//    return self;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    
    NSLog(@"%lu", (unsigned long)items.count);
    
    return items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //CartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
//    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
//    recipeImageView.image = [UIImage imageNamed:[items objectAtIndex:indexPath.row]];
//    
//    
//    UILabel *text1 = (UILabel *)[cell viewWithTag:101];
//    text1.text = @"1";
//    
//    UILabel *text2 = (UILabel *)[cell viewWithTag:102];
//    text2.text = @"2";
//    
//    NSLog(@"row %ld", (long)indexPath.row);
    
    
//    CartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.textLabel.text = [items objectAtIndex:indexPath.row];
//    
//    NSLog(@"row %@", [items objectAtIndex:indexPath.row]);

    
    CartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
//    cell.textLabel.text = [NSString stringWithFormat:@"%li", (long)indexPath.row + 1];
    
    NSMutableDictionary * data = [items objectAtIndex:indexPath.row];

    GoodsModel * model = [data objectForKey:@"model"];
    
    cell.name.text = model.name;
    cell.price.text = [NSString stringWithFormat:@"%@, USD", model.price];
    cell.amount.text = [[data objectForKey:@"amount"] stringValue];
    
    //[data objectForKey:@"amount"] intValue]
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)buy:(id)sender {
}

- (void) viewDidDisappear:(BOOL)animated {
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate showCart];
    
}
@end
