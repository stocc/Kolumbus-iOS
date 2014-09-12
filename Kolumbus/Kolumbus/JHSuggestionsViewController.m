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
    
    NSMutableArray *input;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    self.navigationController.title = @"Suggestions";
    
    input = [[NSMutableArray alloc] initWithArray:@[@"Brandenburger Tor", @"Fernsehturm", @"Alexanderplatz"]];
    
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return input.count;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, width-70, cell.contentView.frame.size.height-20)];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.numberOfLines = 0;
    title.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    title.text = input[indexPath.row];
    [cell.contentView addSubview:title];
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
    return 1;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}

@end
