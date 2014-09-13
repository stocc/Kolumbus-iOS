//
//  JHTimelineViewController.m
//  Kolumbus
//
//  Created by Finn Gaida on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHTimelineViewController.h"

@implementation JHTimelineViewController {
    
    UITableView *tableView;
    CGFloat width;
    CGFloat height;
    
    NSDictionary *input;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    input = [NSDictionary new];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    // loading spinner
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    
}

- (void)loadData:(NSDictionary *)data {
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    if (data[@"error"]) {
        [[[UIAlertView alloc] initWithTitle:@"Wow" message:[NSString stringWithFormat:@"You crashed it :( Error is: %@", data[@"error"]] delegate:nil cancelButtonTitle:@"Cool" otherButtonTitles:nil, nil] show];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
        input = data;
        [tableView reloadData];
        
    }
    
}

#pragma mark Table View delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return input.count;
}

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    NSDictionary *model = input[@"jo"][indexPath.row];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, width-90, 30)];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.numberOfLines = 0;
    title.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    title.text = @"Sup";
    [cell.contentView addSubview:title];
    
    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, width-140, 40)];
    description.backgroundColor = [UIColor clearColor];
    description.textColor = [UIColor colorWithWhite:0 alpha:.7];
    description.textAlignment = NSTextAlignmentLeft;
    description.numberOfLines = 0;
    description.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    description.text = @"Test";
    [cell.contentView addSubview:description];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}

@end
