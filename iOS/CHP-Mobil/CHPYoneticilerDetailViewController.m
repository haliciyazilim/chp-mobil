//
//  CHPYoneticilerDetailViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 15.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPYoneticilerDetailViewController.h"
#import "CHPContact.h"
#import "APIManager.h"

@interface CHPYoneticilerDetailViewController ()

-(void)configureViews;

@end

@implementation CHPYoneticilerDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
- (void)viewWillAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return [[self.chpContact positions] count];
    }
    else if(section == 1){
        return [[self.chpContact phones] count];
    }
    else if(section == 2){
        return [[self.chpContact cellPhones] count];
    }
    else if(section == 3){
        return [[self.chpContact eMails] count];
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"detailCell";
    static NSString *CellIdentifier2 = @"detailUnvanCell";
    
    UITableViewCell *cell;
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    if(indexPath.section == 0){
        [(UILabel *) [cell viewWithTag:2] setText:[self.chpContact.positions objectAtIndex:indexPath.row]];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        ((UILabel *)[cell viewWithTag:2]).highlightedTextColor = [UIColor whiteColor];
        ((UILabel *) [cell viewWithTag:2]).font = [UIFont fontWithName:@"Futura-Medium" size:16];
        ((UILabel *) [cell viewWithTag:2]).textColor = [UIColor whiteColor];
        ((UILabel *) [cell viewWithTag:2]).textAlignment = NSTextAlignmentCenter;
    }
    else if(indexPath.section == 1){
        NSString *phoneString = [[self.chpContact phones] objectAtIndex:indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@ (%@) %@ %@ %@", [phoneString substringWithRange:NSMakeRange(0, 3)], [phoneString substringWithRange:NSMakeRange(3,3)], [phoneString substringWithRange:NSMakeRange(6,3)], [phoneString substringWithRange:NSMakeRange(9,2)], [phoneString substringWithRange:NSMakeRange(11,2)]];
        
        [(UILabel *) [cell viewWithTag:2] setText:str];
        [(UIImageView *) [cell viewWithTag:3] setImage:[UIImage imageNamed:@"icon_phone.png"]];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        ((UILabel *)[cell viewWithTag:2]).highlightedTextColor = [UIColor colorWithRed:0.0 green:0.871 blue:1.0 alpha:1];
        ((UILabel *) [cell viewWithTag:2]).font = [UIFont fontWithName:@"Futura-Medium" size:16];
        ((UILabel *) [cell viewWithTag:2]).textColor = [UIColor colorWithRed:0.694 green:0.694 blue:0.694 alpha:1];
        ((UILabel *) [cell viewWithTag:2]).textAlignment = NSTextAlignmentLeft;
    }
    else if(indexPath.section == 2){
        NSString *phoneString = [[self.chpContact cellPhones] objectAtIndex:indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@ (%@) %@ %@ %@", [phoneString substringWithRange:NSMakeRange(0, 3)], [phoneString substringWithRange:NSMakeRange(3,3)], [phoneString substringWithRange:NSMakeRange(6,3)], [phoneString substringWithRange:NSMakeRange(9,2)], [phoneString substringWithRange:NSMakeRange(11,2)]];
        
        [(UILabel *) [cell viewWithTag:2] setText:str];
        [(UIImageView *) [cell viewWithTag:3] setImage:[UIImage imageNamed:@"icon_cellphone.png"]];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        ((UILabel *)[cell viewWithTag:2]).highlightedTextColor = [UIColor colorWithRed:0.0 green:0.871 blue:1.0 alpha:1];
        ((UILabel *) [cell viewWithTag:2]).font = [UIFont fontWithName:@"Futura-Medium" size:16];
        ((UILabel *) [cell viewWithTag:2]).textColor = [UIColor colorWithRed:0.694 green:0.694 blue:0.694 alpha:1];
        ((UILabel *) [cell viewWithTag:2]).textAlignment = NSTextAlignmentLeft;
    }
    else if(indexPath.section == 3){
        [(UILabel *) [cell viewWithTag:2] setText:[[self.chpContact eMails] objectAtIndex:indexPath.row]];
        [(UIImageView *) [cell viewWithTag:3] setImage:[UIImage imageNamed:@"icon_mail.png"]];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        ((UILabel *)[cell viewWithTag:2]).highlightedTextColor = [UIColor colorWithRed:0.0 green:0.871 blue:1.0 alpha:1];
        ((UILabel *) [cell viewWithTag:2]).font = [UIFont fontWithName:@"Futura-Medium" size:16];
        ((UILabel *) [cell viewWithTag:2]).textColor = [UIColor colorWithRed:0.694 green:0.694 blue:0.694 alpha:1];
        ((UILabel *) [cell viewWithTag:2]).textAlignment = NSTextAlignmentLeft;
    }
    
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return nil;
    }
    else if(section == 1){
        if([[self.chpContact phones] count] != 0){
            UIView *section1Header = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 20.0)];
            UIImageView *separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 4.0, 280.0, 1.0)];
            separatorLine.image = [UIImage imageNamed:@"seperator_yonetici.png"];
            [section1Header addSubview:separatorLine];
            return section1Header;
        }
        else{
            return nil;
        }
    }
    else if(section == 2){
        return nil;
    }
    else if(section == 3){
        if([[self.chpContact eMails] count] != 0){
            UIView *section2Header = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 20.0)];
            UIImageView *separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 4.0, 280.0, 1.0)];
            separatorLine.image = [UIImage imageNamed:@"seperator_yonetici.png"];
            [section2Header addSubview:separatorLine];
            return section2Header;
        }
        else{
            return nil;
        }
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.0;
    }
    else if(section == 1){
        if([[self.chpContact phones] count] != 0){
            return 12.0;
        }
        else{
            return 0.0;
        }
    }
    else if(section == 2){
        return 0.0;
    }
    else{
        if([[self.chpContact eMails] count] != 0){
            return 12.0;
        }
        else{
            return 0.0;
        }
    }
    return 0.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 30.0;
    }
    else{
        return 44;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1) {
        NSString *phoneNumber = [[self.chpContact phones] objectAtIndex:indexPath.row];
        NSString *phoneUrl = [NSString stringWithFormat:@"tel:%@",phoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneUrl]];
    } else if (indexPath.section == 2) {
        NSString *phoneNumber = [[self.chpContact cellPhones] objectAtIndex:indexPath.row];
        NSString *phoneUrl = [NSString stringWithFormat:@"tel:%@",phoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneUrl]];
    } else if(indexPath.section == 3) {
        if ([MFMailComposeViewController canSendMail]) {
            // Show the composer
            MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
            controller.mailComposeDelegate = self;
            [controller setToRecipients:@[[(UILabel *) [[tableView cellForRowAtIndexPath:indexPath] viewWithTag:2] text]]];
            
            if (controller) [self presentViewController:controller
                                               animated:YES
                                             completion:^{
                                                 
                                             }];
        } else {
            // Handle the error
        }
    }
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section == 0){
        return 10.0;
    }
    else{
        return 0.0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0){
        UIView *footerView = [[UIView alloc] init];
        return footerView;
    }
    else{
        return nil;
    }
}

- (void)setChpContact:(CHPContact *)chpContact{
    if (_chpContact != chpContact) {
        _chpContact = chpContact;
//        _positionsOfContact = [self.chpContact getPositionStringsArray];
    }
    [self configureViews];
}
- (void)configureViews{
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0,0.0,320.0,240.0)];
    UIImageView *vesikaHolder = [[UIImageView alloc] initWithFrame:CGRectMake(82.0, 20.0, 156.0, 198.0)];
    vesikaHolder.image = [UIImage imageNamed:@"vesika_imageholder.png"];
    
    UIImageView *vesikaImage = [[UIImageView alloc] initWithFrame:CGRectMake(97.0, 31.0, 128.0, 167.0)];
    [vesikaImage setContentMode:UIViewContentModeScaleAspectFill];
    [vesikaImage setClipsToBounds:YES];
    vesikaImage.image = [UIImage imageNamed:@"vesika_yok.png"];
    
    if ([[self.chpContact imageURL] isEqualToString:@""] || [self.chpContact imageURL] == nil) {
        
    }
    else{
        [[APIManager sharedInstance] getImageWithURLString:[self.chpContact imageURL]
                                              onCompletion:^(UIImage *resultImage) {
                                                  [vesikaImage setImage:resultImage];
                                              } onError:^(NSError *error) {
                                                  
                                              }];
    }
    
    [tableHeaderView addSubview:vesikaHolder];
    [tableHeaderView addSubview:vesikaImage];
    
    UILabel *managerName = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 210.0, 320.0, 32.0)];
    managerName.text = self.chpContact.name;
    managerName.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:18];
    managerName.shadowColor = [UIColor blackColor];
    managerName.textAlignment = NSTextAlignmentCenter;
    managerName.backgroundColor = [UIColor clearColor];
    managerName.textColor = [UIColor whiteColor];
    
    [tableHeaderView addSubview:managerName];
    
    self.tableView.tableHeaderView = tableHeaderView;
    
    [self.tableView reloadData];

}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error {
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 
                             }];
}

@end
