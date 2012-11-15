//
//  CHPBizKimizDetailViewController.h
//  CHP-Mobil
//
//  Created by Yunus Eren Guzel on 11/15/12.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHPBizKimizDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
-(void) setContent:(NSString*) i;
@end
