

import UIKit
class CircleLayout : UICollectionViewLayout {
    
    fileprivate var attrsArr = [UICollectionViewLayoutAttributes]() //所有item的属性
    
    override func prepare() {
        super.prepare()
        self.attrsArr.removeAll()
        creatAttrs()
    }
    
    func creatAttrs()  {
        //计算出每组有多少个
        let count : Int = (self.collectionView?.numberOfItems(inSection: 0))!
        /**
         * 因为不是继承流水布局 UICollectionViewFlowLayout
         * 所以我们需要自己创建 UICollectionViewLayoutAttributes
         */
        //如果是多组的话  需要2层循环
        for i in 0..<count {
            //创建UICollectionViewLayoutAttributes
            let indexPath = IndexPath.init(item: i, section: 0)
            //这里需要 告诉 UICollectionViewLayoutAttributes 是哪里的attrs
            let attrs = layoutAttributesForItem(at: indexPath)
            self.attrsArr.append(attrs!)
        }
      
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attrsArr
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //创建UICollectionViewLayoutAttributes
        //这里需要 告诉 UICollectionViewLayoutAttributes 是哪里的attrs
        //计算出每组有多少个
        let  count : CGFloat = CGFloat((self.collectionView?.numberOfItems(inSection: 0))!)
        //角度
        let angle = 2.0 * .pi / count * CGFloat(indexPath.item)
        //设置半径
        let radius :CGFloat = 100.0;
        //CollectionView的圆心的位置
        let Ox = (self.collectionView?.frame.size.width)!/2.0
        let Oy = (self.collectionView?.frame.size.height)!/2.0
        let attrs = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        attrs.center =  CGPoint(x:Ox+radius*sin(angle), y:Oy+radius*cos(angle))
        if (count==1) {
            attrs.size=CGSize(width:200, height:200)
        }else{
            attrs.size=CGSize(width:50, height:50)
        }
        return attrs
        
    }
    
    
    
}
