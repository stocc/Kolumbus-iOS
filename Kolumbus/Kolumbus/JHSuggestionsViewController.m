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
    
    NSMutableArray *input;
    NSMutableArray *switches;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    is7 = ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] <= 7);
    
    self.title = @"Suggestions";
    
    // Test data
    input = [[NSMutableArray alloc] initWithArray:@[@[@"Brandenburger Tor", @"Fernsehturm", @"Alexanderplatz"], @[@"Sehr großes Tor", @"Sehr großer Turm", @"Sehr großer Platz"]]];
    switches = [NSMutableArray new];
    
    // Tableview Setup
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = (is7) ? UIEdgeInsetsMake(70, 0, 0, 0) : UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:tableView];
    
    // Show all on Map
    UIBarButtonItem *map = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"place4"] style:UIBarButtonItemStyleBordered target:self action:@selector(showMap)];
    self.navigationItem.rightBarButtonItem = map;
    
    // Finish button
    JHButton *finish = [[JHButton alloc] initWithFrame:CGRectMake(20, height-70, width-40, 50)];
    finish.layer.masksToBounds = YES;
    finish.layer.cornerRadius = finish.frame.size.height/2;
    [finish setNormalColor:[UIColor colorWithRed:(24.0/255.0) green:(49.0/255.0) blue:(63.0/255.0) alpha:1]];
    [finish setHighlightedColor:[UIColor colorWithRed:(20.0/255.0) green:(45.0/255.0) blue:(60.0/255.0) alpha:1]];
    [finish addTarget:self action:@selector(finishSuggestions) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finish];
    
    UILabel *finishText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width-40, 50)];
    finishText.backgroundColor = [UIColor clearColor];
    finishText.textColor = [UIColor whiteColor];
    finishText.textAlignment = NSTextAlignmentCenter;
    finishText.numberOfLines = 0;
    finishText.font = [UIFont fontWithName:@"Helvetica Neue" size:30];
    finishText.text = @"Fertig";
    [finish addSubview:finishText];
}

#pragma mark Finns Funny Functions!
- (void)showMap {
    // TODO
}

- (void)finishSuggestions {
    
}


#pragma mark Table View delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [input[0] count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 50, 50)];
    pic.layer.masksToBounds = YES;
    pic.layer.cornerRadius = pic.frame.size.width/2;
    pic.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%i", indexPath.row]];
    [cell.contentView addSubview:pic];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, width-90, 30)];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.numberOfLines = 0;
    title.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    title.text = input[0][indexPath.row];
    [cell.contentView addSubview:title];
    
    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, width-140, 40)];
    description.backgroundColor = [UIColor clearColor];
    description.textColor = [UIColor colorWithWhite:0 alpha:.7];
    description.textAlignment = NSTextAlignmentLeft;
    description.numberOfLines = 0;
    description.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    description.text = input[1][indexPath.row];
    [cell.contentView addSubview:description];
    
    // Select for route or not
    UISwitch *selectedSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(width-70, [self tableView:tv heightForRowAtIndexPath:indexPath]/2-10, 50, 20)];
    [selectedSwitch setOn:YES animated:YES];
    [cell.contentView addSubview:selectedSwitch];
    
    // add to array for later modification
    [switches addObject:selectedSwitch];
    
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
    
    // invert the switch
    [(UISwitch *)switches[indexPath.row] setOn:![(UISwitch *)switches[indexPath.row] isOn] animated:YES];
    
}

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}

@end
