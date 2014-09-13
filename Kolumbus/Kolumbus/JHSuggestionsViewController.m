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
    NSMutableArray *switches;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    is7 = ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] <= 7);
    
    self.title = @"Vorschläge";
    
    // Test data
    NSData __unused *testData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"]];
    input = [NSDictionary new]; // = [NSJSONSerialization JSONObjectWithData:testData options:NSJSONReadingMutableLeaves error:nil];
    switches = [NSMutableArray new];
    
    // Tableview Setup
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    [self.view addSubview:tableView];
    
    // Show all on Map
    UIBarButtonItem *map = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"place4"] style:UIBarButtonItemStyleBordered target:self action:@selector(showMap)];
    self.navigationItem.rightBarButtonItem = map;
    
    // Finish button
    JHButton *finish = [[JHButton alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-44, self.view.frame.size.width, 44)];
    [finish setNormalColor:[UIColor colorWithRed:(255.0/255.0) green:(142.0/255.0) blue:(7.0/255.0) alpha:1]];
    [finish setHighlightedColor:[UIColor colorWithRed:(255.0/255.0) green:(105.0/255.0) blue:(47.0/255.0) alpha:1]];
    [finish addTarget:self action:@selector(finishSuggestions) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finish];
    
    UILabel *finishText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    finishText.backgroundColor = [UIColor clearColor];
    finishText.textColor = [UIColor whiteColor];
    finishText.textAlignment = NSTextAlignmentCenter;
    finishText.numberOfLines = 0;
    finishText.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    finishText.text = @"Plane meinen Tag!";
    [finish addSubview:finishText];
    
    // loading spinner
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    
    
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
    
    JHTimelineViewController *timelineVC = [[JHTimelineViewController alloc] init];
    [self.navigationController pushViewController:timelineVC animated:YES];
    
    [JHCommunicator getFinalTripFrom:[NSDate new] until:[NSDate new] spots:@[] finish:^(NSDictionary *response) {
       
        [timelineVC loadData:response];
        
    }];
}

- (void)loadData:(NSDictionary *)data {
    
    if (data) {
        
        input = data;
        
        NSLog(@"%i", [input[input.allKeys[1]] count]);
        
        // hide spinner
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        for (int i=0; i<input.allKeys.count; i++) {
            
            for (id __unused item in input[input.allKeys[i]]) {
                [switches addObject:@0];
            }
        }
        
        [tableView reloadData];
        
    }
    
}


#pragma mark Table View delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return input.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [input[input.allKeys[section]] count];
}

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    NSLog(@"Section: %i   Row: %i", indexPath.section, indexPath.row);
    
    NSDictionary *model = input[input.allKeys[indexPath.section]][indexPath.row];
    
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
    description.text = model[@"id"];
    [cell.contentView addSubview:description];
    
    
    if (switches.count>=indexPath.row) {
        //cell.accessoryType = ([switches[indexPath.row]  isEqual: @0]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    
    /*/ Select for route or not
    UISwitch *selectedSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(width-70, [self tableView:tv heightForRowAtIndexPath:indexPath]/2-10, 50, 20)];
    [selectedSwitch setOn:YES animated:YES];
    [cell.contentView addSubview:selectedSwitch];
    
    // add to array for later modification
    [switches addObject:selectedSwitch];*/
    
    return cell;
    
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
