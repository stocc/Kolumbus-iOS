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
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
}

- (void)loadData:(NSDictionary *)data {
    
}

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}

@end
