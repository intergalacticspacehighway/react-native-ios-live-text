import UIKit
import VisionKit
import Vision

@objc(LiveTextImageViewViewManager)
class LiveTextImageViewViewManager: RCTViewManager {
    

    override func view() -> (UIView) {
        if #available(iOS 16.0, *) {
            return LiveTextImageViewView()
        } else {
            return UIView()
            // Fallback on earlier versions
        }
  }

  @objc override static func requiresMainQueueSetup() -> Bool {
    return false
  }
}

@available(iOS 16.0, *)
class LiveTextImageViewView : UIView {
  
  

    private lazy var interaction: ImageAnalysisInteraction = {
        let interaction = ImageAnalysisInteraction()
        interaction.preferredInteractionTypes = .automatic
        return interaction
    }()

    private let imageAnalyzer = ImageAnalyzer()
    
    @objc var enabled: Bool = false {
        didSet {
            if (enabled) {
            
            if let image = self.subviews.first as? RCTImageView {
                
                let imageView = image.imageView;
                imageView?.addInteraction(interaction)
                guard let image = imageView?.image else {
                    return
                }
                
                Task {
                    let configuration = ImageAnalyzer.Configuration([.text])
                    
                    do {
                        let analysis = try await imageAnalyzer.analyze(image, configuration: configuration)
                        
                        DispatchQueue.main.async {
                            self.interaction.analysis = nil
                            self.interaction.preferredInteractionTypes = []
                            
                            self.interaction.analysis = analysis
                            self.interaction.preferredInteractionTypes = .automatic
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
           
        }
    }
}
  
    
    
    

  func hexStringToUIColor(hexColor: String) -> UIColor {
    let stringScanner = Scanner(string: hexColor)

    if(hexColor.hasPrefix("#")) {
      stringScanner.scanLocation = 1
    }
    var color: UInt32 = 0
    stringScanner.scanHexInt32(&color)

    let r = CGFloat(Int(color >> 16) & 0x000000FF)
    let g = CGFloat(Int(color >> 8) & 0x000000FF)
    let b = CGFloat(Int(color) & 0x000000FF)

    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
  }
}
