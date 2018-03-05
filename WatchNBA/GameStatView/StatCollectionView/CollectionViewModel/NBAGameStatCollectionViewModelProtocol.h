//
//  NBAGameStatCollectionViewModelProtocol.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NBAGameStatCollectionViewModelProtocol <NSObject>

+ (Class)collectionViewCellClass;

- (CGSize)collectionView:(UICollectionView *)aCollectionView layout:(UICollectionViewLayout*)aCollectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)aIndexPath;

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)aIndexPath;

- (NSInteger)collectionView:(UICollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)aSection;
@end
