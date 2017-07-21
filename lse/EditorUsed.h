//
//  EditorUsed.h
//  lse
//
//  Created by Centny on 21/07/2017.
//  Copyright © 2017 Centny. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class EditorUsed;
//
//@protocol EditorUsedDelegate <NSObject>
//
//-(void)onSelect:(EditorUsed*)used;
//
//@end

@interface EditorUsed : UICollectionViewCell
@property(nonatomic)IBOutlet UILabel* title;
@property(nonatomic)NSString* text;
//@property(nonatomic,assign)id<EditorUsedDelegate> delegate;
//-(IBAction)onClick:(id)sender;
@end
