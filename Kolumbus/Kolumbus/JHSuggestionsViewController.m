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
    NSMutableArray *switches;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    self.title = @"Suggestions";
    
    input = [[NSMutableArray alloc] initWithArray:@[@"Brandenburger Tor", @"Fernsehturm", @"Alexanderplatz"]];
    switches = [NSMutableArray new];
    
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
    
    UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    pic.layer.masksToBounds = YES;
    pic.layer.cornerRadius = pic.frame.size.width/2;
    [cell.contentView addSubview:pic];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, width-70, cell.contentView.frame.size.height-20)];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.numberOfLines = 0;
    title.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    title.text = input[indexPath.row];
    [cell.contentView addSubview:title];
    
    UISwitch *selectedSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(width-70, [self tableView:tv heightForRowAtIndexPath:indexPath]/2-10, 50, 20)];
    [selectedSwitch setOn:YES animated:YES];
    [cell.contentView addSubview:selectedSwitch];
    
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
