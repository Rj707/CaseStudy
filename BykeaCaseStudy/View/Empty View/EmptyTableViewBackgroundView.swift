

import UIKit

class EmptyTableViewBackgroundView: UIView
{

    @IBOutlet weak var imageView: UIImageView!
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noResultButton: UIButton!
    

    var noResultButtonAction : (() -> ())?
    
    class func instanceFromNib() -> EmptyTableViewBackgroundView
    {
        return UINib(nibName: "EmptyTableViewBackgroundView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptyTableViewBackgroundView
    }

    @IBAction func noResultButtonTouched(_ sender: Any)
    {
        noResultButtonAction?()
    }
    
}
