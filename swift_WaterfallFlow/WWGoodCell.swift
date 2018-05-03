
import UIKit

class WWGoodCell: UICollectionViewCell {

    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var imageview: UIImageView!

    @IBOutlet var selectBtn: UIButton!
    var good:WWGood?
    
    func setGoodData(_ good:WWGood) {
        self.good = good
        let url = URL.init(string: good.img!)
        self.imageview.sd_setImage(with: url)
        self.priceView.text = good.price
        
    }
    
}
