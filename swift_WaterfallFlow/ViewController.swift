
import UIKit

class ViewController: UICollectionViewController {

    // 商品列表数组
    var goodsList = [WWGood]()
    // 当前的数据索引
    var index:Int8 = 0
    // 底部视图
    var footerView:WWCollectionFooterView?
    // 是否正在加载数据标记
    var loading = false
    // 瀑布流布局
    @IBOutlet weak var flowLayout: WWCollectionFlowLayout!
    
    @IBOutlet var lineLayout: LineLayout!
    
    @IBOutlet var customLayout: CustomLayout!
    
    @IBOutlet var squareLayout: SquareLayout!
    
    @IBOutlet var circleLayout: CircleLayout!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white
        self.loadData()
        addChangedBtn()
    }
    
    func addChangedBtn()
    {
        //1.创建btn
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect(x:200,y:300, width:80, height:80)
        // 2.设置按钮的图片
        btn.setBackgroundImage(UIImage.init(named: "on"), for: .normal)
        btn.setBackgroundImage(UIImage.init(named: "on"), for: .highlighted)
        btn.addTarget(self, action: #selector(changedLayout), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func changedLayout()
    {
        
        if (self.collectionView?.collectionViewLayout.isKind(of: WWCollectionFlowLayout.self))!{
        self.collectionView?.setCollectionViewLayout(self.lineLayout, animated: true)
        }else if(self.collectionView?.collectionViewLayout.isKind(of: LineLayout.self))!{
        self.collectionView?.setCollectionViewLayout(self.customLayout, animated: true)
        }else if(self.collectionView?.collectionViewLayout.isKind(of: CustomLayout.self))!{
        self.collectionView?.setCollectionViewLayout(self.squareLayout, animated: true)
        }else if(self.collectionView?.collectionViewLayout.isKind(of: SquareLayout.self))!{
            self.collectionView?.setCollectionViewLayout(self.circleLayout, animated: true)
        }else{
        self.collectionView?.setCollectionViewLayout(self.flowLayout, animated: true)
        }
    }
    
    func loadData() {
        let goods = WWGood.goodsWithIndex(self.index)
        self.goodsList.append(contentsOf: goods as! [WWGood])
        self.index += 1
        // 设置布局的属性
        self.flowLayout.columnCount = 4
        self.flowLayout.goodsList = self.goodsList
        self.collectionView?.reloadData()
    }
    
//MARK:- UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.goodsList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodCellCache", for: indexPath) as! WWGoodCell

        cell.setGoodData(self.goodsList[(indexPath as NSIndexPath).item])
        return cell;
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionV : WWGoodCell = collectionView.cellForItem(at: indexPath) as!WWGoodCell
        collectionV.selectBtn.isSelected = true
        
    }
    
//MARK:-FooterView
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter {
            self.footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterViewCache", for: indexPath) as? WWCollectionFooterView
        }
        return self.footerView!
    }

//MARK:-scrollView代理方法
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.footerView == nil || self.loading == true {
            return
        }
        
        if self.footerView!.frame.origin.y < (scrollView.contentOffset.y + scrollView.bounds.size.height) {
            NSLog("开始刷新"); 
            self.loading = true
            self.footerView?.indicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                self.footerView = nil
                self.loadData()
                self.loading = false
            })
        }
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}


