
import UIKit
class LineLayout : UICollectionViewFlowLayout {

    override func prepare() {
        self.itemSize = CGSize(width:150,height:150)
        self.scrollDirection = .horizontal
        let imsert = ((self.collectionView?.frame.size.width)! - self.itemSize.width)/2.0
        self.sectionInset = UIEdgeInsetsMake(0, imsert, 0, imsert)
        self.minimumLineSpacing = 50.0
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var rect : CGRect = CGRect()
        rect.origin.x = proposedContentOffset.x
        rect.origin.y = 0
        rect.size = (self.collectionView?.frame.size)!
        
        let array = super.layoutAttributesForElements(in: rect)
        let centerX = (self.collectionView?.frame.size.width)!/2.0 + proposedContentOffset.x
        var minDelta : CGFloat = CGFloat(MAXFLOAT)
        for attrs in array! {
            if ( abs(minDelta) > abs(attrs.center.x-centerX)) {
                minDelta = attrs.center.x - centerX
            }
        }
       
        //如果返回的时zero 那个滑动停止后 就会立刻回到原地
        return CGPoint(x:(proposedContentOffset.x + minDelta),y:proposedContentOffset.y)
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElements(in: rect)
        let centetX = (self.collectionView?.contentOffset.x)! + (self.collectionView?.frame.size.width)!/2;
        for attrs in array! {
            //CGFloat scale = arc4random_uniform(100)/100.0;
            //attrs.indexPath.item 表示 这个attrs对应的cell的位置
            
            //cell的中心点x 和CollectionView最中心点的x值
            let delta = abs(attrs.center.x - centetX)
            //根据间距值  计算cell的缩放的比例
            //这里scale 必须要 小于1
            let scale = 1 - delta/(self.collectionView?.frame.size.width)!
            //设置缩放比例
            attrs.transform=CGAffineTransform(scaleX: scale, y: scale)
        }
        return array
     
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

}
