//
//  EditorForm.h
//  ude
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Dayang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditorForm : UIScrollView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic)IBOutlet UITextView* title;
@property(nonatomic)IBOutlet UITextField* tags;
@property(nonatomic)IBOutlet UICollectionView* usedTags;
@property(nonatomic)IBOutlet UITextField* from;
@property(nonatomic)IBOutlet UICollectionView* usedFrom;
@property(nonatomic)IBOutlet UITextField* image;
@property(nonatomic)IBOutlet UIImageView* preview;
@property(nonatomic)IBOutlet UITextView* desc;
@property(nonatomic)IBOutlet UILabel* info;
@property(nonatomic)IBOutlet UIButton* submit;
@property(nonatomic)NSMutableArray* tagList;
@property(nonatomic)NSMutableArray* fromList;
-(IBAction)onSubmit:(id)sender;
@end
