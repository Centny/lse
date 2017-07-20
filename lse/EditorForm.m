//
//  EditorForm.m
//  ude
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Dayang. All rights reserved.
//

#import "EditorForm.h"

@implementation EditorForm

- (void)awakeFromNib{
    [super awakeFromNib];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.contentSize=CGSizeMake(frame.size.width, self.submit.frame.origin.y+self.submit.frame.size.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.usedTags==collectionView){
        return self.tagList.count;
    }else{
        return self.fromList.count;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"text" forIndexPath:indexPath];
    UILabel* text=[cell viewWithTag:100];
    if(text==nil){
        text=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 10)];
        [cell addSubview:text];
    }
    if(self.usedTags==collectionView){
        text.text=[self.tagList objectAtIndex:indexPath.row];
    }else{
        text.text=[self.fromList objectAtIndex:indexPath.row];
    }
    cell.frame=CGRectMake(0, 0, 50, 10);
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(IBAction)onSubmit:(id)sender{
    
}
@end
