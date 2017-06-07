import UIKit

// スワイプで塗りつぶしができるImageView
class PaintImageView: UIImageView {
    
    // Input Mode
    var mode: Mode = Mode.Pen
    
    // 線の太さ
    var strokeWidth: CGFloat = 10.0
    
    // タップした位置
    private var tapedPoint: CGPoint = CGPoint()
    
    // 塗りつぶす前の元の画像
    private var originalImage: UIImage = UIImage()
    
    // MARK: 初期化メソッド
    func initialize() {
        self.isUserInteractionEnabled = true
        
        guard let image = self.image else {
            // imageの監視スタート
            self.addObserver(self, forKeyPath: "image", options: .new, context: nil)
            return
        }
        
        self.originalImage = image
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    // MARK: 画面タップイベント
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            tapedPoint = touch.location(in: self)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let endPoint = touch.location(in: self)
            
            switch (mode) {
            case Mode.Pen: fallthrough
            case Mode.Eraser: draw(endPoint)
            case Mode.Text: return;
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let endPoint = touch.location(in: self)

            if (mode == Mode.Text) {
                self.image = textToImage(drawText: "Oops!", atPoint: endPoint, textColor: nil, textFont: nil)
            }
        }
    }
    
    // MARK: imageが設定された際に呼ばれる
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "image" {
            
            // 画像を保持しておく
            originalImage = change![NSKeyValueChangeKey.newKey] as! UIImage
            
            // もう監視しない
            self.removeObserver(self, forKeyPath: "image")
        }
    }
    
    // MARK: 線を描画する
    func draw(_ endPoint: CGPoint) {
        
        if (mode == Mode.Text) {
            return
        }
        
        // ビットマップ画像のコンテキストを作成
        UIGraphicsBeginImageContext(self.frame.size);
        
        // 現在の画像を描画
        self.image?.draw(in: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        
        // 移動距離を算出
        let length: Float = sqrt(Float(pow(tapedPoint.x - endPoint.x, 2)+pow(tapedPoint.y - endPoint.y, 2)))
        if (length == 0) {
            return
        }
        
        let strokeWidth: CGFloat
        if length <= 5 {
            strokeWidth = 1

        } else {
            strokeWidth = CGFloat(length / 5.0)

        }
        
        print(strokeWidth)
        print(length)
        
        // 線の太さと色の指定
        UIGraphicsGetCurrentContext()!.setLineWidth(strokeWidth);
        switch mode {
        case .Eraser: UIGraphicsGetCurrentContext()!.setStrokeColor(red: 1, green: 1, blue: 1, alpha: 1.0);
        case .Pen: UIGraphicsGetCurrentContext()!.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1.0);
        default: return
        }
        
        
        // 線の角を丸くする
        UIGraphicsGetCurrentContext()!.setLineCap(.round);
        
        // 線の始点と終点を設定する
        let context = UIGraphicsGetCurrentContext()!
        context.move(to: CGPoint(x: tapedPoint.x, y: tapedPoint.y));
        context.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y));
        
        // 線を引く
        UIGraphicsGetCurrentContext()!.strokePath();
        
        // 線が引かれた画像を自分に設定する
        self.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 描画領域を解放
        UIGraphicsEndImageContext();
        
        // 現在のタッチ座標を次に線を引く開始座標にする
        tapedPoint = endPoint;
    }
    
    func textToImage(drawText text: NSString, atPoint point: CGPoint, textColor: UIColor?, textFont: UIFont?) -> UIImage {
        // Setup the font specific variables
        var _textColor: UIColor
        if textColor == nil {
            _textColor = UIColor.black
        } else {
            _textColor = textColor!
        }
        
        var _textFont: UIFont
        if textFont == nil {
            _textFont = UIFont.systemFont(ofSize: 16)
        } else {
            _textFont = textFont!
        }
        
        // Setup the image context using the passed image
        let size = self.frame.size
        UIGraphicsBeginImageContext(size)
        
        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSFontAttributeName: _textFont,
            NSForegroundColorAttributeName: _textColor,
            ] as [String : Any]
        
        // Put the image into a rectangle as large as the original image
        draw(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // Create a point within the space that is as bit as the image
        let rect = CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
        
        // Draw the text into an image
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //Pass the image back up to the caller
        return newImage!
    }
    
    // MARK: 塗りつぶした線を全部消して元の画像に戻す
    func clear() {
        self.image = nil
        self.image = originalImage
    }
}

enum Mode {
    case Pen, Eraser, Text
}
