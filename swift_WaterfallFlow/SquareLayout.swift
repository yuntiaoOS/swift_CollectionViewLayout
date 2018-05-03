

import UIKit


class SquareLayout : UICollectionViewLayout {

    var columnCount:Int = 0 // 总列数
    var goodsList = [WWGood]() // 商品数据数组
    fileprivate var layoutAttributesArray = [UICollectionViewLayoutAttributes]() //所有item的属性
    override func prepare() {
        
        
        self.layoutAttributesArray.removeAll()
        let count : Int = (self.collectionView?.numberOfItems(inSection: 0))!
        for i in 0..<count {
            let indexPath = IndexPath.init(item: i, section: 0)
            let attrs = layoutAttributesForItem(at: indexPath)
            self.layoutAttributesArray.append(attrs!)
            
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.layoutAttributesArray
    }
    
    override var collectionViewContentSize: CGSize {
        let count = self.collectionView?.numberOfItems(inSection: 0)
        let rows = (CGFloat(count!) + 3.0 - 1.0)/3.0
        let rowH = (self.collectionView?.frame.size.width)!/2.0
        if (count!%6 == 2)||(count!%6 == 4) {
            return CGSize(width:0,height:rows*rowH - rowH/2.0)
        }else{
            return CGSize(width:0,height:rows*rowH)
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let width = (self.collectionView?.frame.size.width)!*0.5
        let attrs = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        let height = width
        let i = indexPath.item
        if i==0 {
            attrs.frame = CGRect(x:0,y:0,width:width,height:height)
        }else if i==1 {
            attrs.frame = CGRect(x:width,y:0,width:width,height:height/2)
        }else if i==2 {
            attrs.frame = CGRect(x:width,y:height/2,width:width,height:height/2)
        }else if i==3 {
            attrs.frame = CGRect(x:0,y:height,width:width,height:height/2)
        }else if i==4 {
            attrs.frame = CGRect(x:0,y:height+height/2,width:width,height:height/2)
        }else if i==5 {
            attrs.frame = CGRect(x:width,y:height,width:width,height:height)
        }else {
            let lastAttrs = self.layoutAttributesArray[i-6]
            var frame = lastAttrs.frame
            frame.origin.y =  frame.origin.y + height*2
            
            attrs.frame = frame
        }
        return attrs
    }

}
