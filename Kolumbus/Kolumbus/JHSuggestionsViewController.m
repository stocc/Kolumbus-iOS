//
//  JHSuggestionsViewController.m
//  Kolumbus
//
//  Created by Finn Gaida on 12.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHSuggestionsViewController.h"

@implementation JHSuggestionsViewController {
    
    UITableView *tableView;
    CGFloat width;
    CGFloat height;
    
    BOOL is7;
    
    NSDictionary *input;                // the parsed data from the server
    NSArray *businesses;
    NSMutableArray *switches;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    is7 = ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] <= 7);
    
    self.title = @"Vorschläge";
    
    // Test data
    NSData *testData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"]];
    input = [NSJSONSerialization JSONObjectWithData:testData options:NSJSONReadingMutableLeaves error:nil];
    switches = [NSMutableArray new];
    
    // Tableview Setup
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    // tableView.contentInset = (is7) ? UIEdgeInsetsMake(70, 0, 0, 0) : UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:tableView];
    
    // Show all on Map
    UIBarButtonItem *map = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"place4"] style:UIBarButtonItemStyleBordered target:self action:@selector(showMap)];
    self.navigationItem.rightBarButtonItem = map;
    
    // Finish button
    JHButton *finish = [[JHButton alloc] initWithFrame:CGRectMake(0, height-40, width, 40)];
    [finish setNormalColor:[UIColor colorWithRed:(30.0/255.0) green:(50.0/255.0) blue:(65.0/255.0) alpha:1]];
    [finish setHighlightedColor:[UIColor colorWithRed:(15.0/255.0) green:(40.0/255.0) blue:(55.0/255.0) alpha:1]];
    [finish addTarget:self action:@selector(finishSuggestions) forControlEvents:UIControlEventTouchUpInside];
    [((UIWindow *)[[UIApplication sharedApplication] windows][0]) addSubview:finish];
    
    UILabel *finishText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    finishText.backgroundColor = [UIColor clearColor];
    finishText.textColor = [UIColor whiteColor];
    finishText.textAlignment = NSTextAlignmentCenter;
    finishText.numberOfLines = 0;
    finishText.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    finishText.text = @"Plane meinen Tag!";
    [finish addSubview:finishText];
    
    
    // ================================================================================================
    
    /*/ Testing area 51
    
    NSDictionary *test = [JHCommunicator getSearch:@"store" coordinates:[[CLLocation alloc] initWithLatitude:52.530639 longitude:13.413480]];
    NSLog(@"test: %@", test[@"foursquare"][@"venues"]);             //*/
}

#pragma mark Finns Funny Functions!
- (void)showMap {
    // TODO
    
    JHMapViewController *mapVC = [[JHMapViewController alloc] initWithRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(53.0, 13.0), MKCoordinateSpanMake(1, 1))];
    [self.navigationController pushViewController:mapVC animated:YES];
    
}

- (void)finishSuggestions {
    // TODO
}

- (void)loadData:(NSDictionary *)data {
    
    if (data) {
        
        if (!data[@"error"]) {
            input = data;
        }
        
        businesses = input[@"yelp"][@"hash"][@"businesses"];
        
        NSLog(@"%i", businesses.count);
        
        [tableView reloadData];
        
    }
    
}


#pragma mark Table View delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return businesses.count-1;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    NSDictionary *model = businesses[indexPath.row];
    
    UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 50, 50)];
    pic.layer.masksToBounds = YES;
    pic.layer.cornerRadius = pic.frame.size.width/2;
    [pic sd_setImageWithURL:[NSURL URLWithString:model[@"snippet_image_url"]] placeholderImage:[UIImage imageNamed:@"icon1"]];
    [cell.contentView addSubview:pic];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, width-90, 30)];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.numberOfLines = 0;
    title.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    title.text = model[@"name"];
    [cell.contentView addSubview:title];
    
    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, width-140, 40)];
    description.backgroundColor = [UIColor clearColor];
    description.textColor = [UIColor colorWithWhite:0 alpha:.7];
    description.textAlignment = NSTextAlignmentLeft;
    description.numberOfLines = 0;
    description.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    //description.text = input[1][indexPath.row];
    [cell.contentView addSubview:description];
    
    cell.accessoryType = ([switches[indexPath.row]  isEqual: @0]) ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark;
    
    /*/ Select for route or not
    UISwitch *selectedSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(width-70, [self tableView:tv heightForRowAtIndexPath:indexPath]/2-10, 50, 20)];
    [selectedSwitch setOn:YES animated:YES];
    [cell.contentView addSubview:selectedSwitch];
    
    // add to array for later modification
    [switches addObject:selectedSwitch];*/
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    
    // invert the switch/ checkmark
    //[(UISwitch *)switches[indexPath.row] setOn:![(UISwitch *)switches[indexPath.row] isOn] animated:YES];
    switches[indexPath.row] = ([switches[indexPath.row]  isEqual: @0]) ? @1 : @0;
    [tv reloadData];
}

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}

@end
