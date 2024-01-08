


import UIKit



class ViewControllerTips: UIViewController, UITextFieldDelegate {
    @IBOutlet var TipLabel: UILabel!
    @IBOutlet var pictureLabel: UIImageView!
    @IBOutlet var nextTipButtonWasClicked: UIButton!
    
    // Array containing health tips
    let Tips: [String] = [
        NSLocalizedString("Drink a Glass of Water in the Morning", comment: "Tip about drinking water"),
        NSLocalizedString("Exercise at least 15 mins a day", comment: "Tip about daily exercise"),
        NSLocalizedString("Sleep 8 hours everynight", comment: "Tip about sleep duration")
    ]
    let pictureNames = ["Water", "Running", "Sleeping"]
    // Array to store UIImages
        var picture: [UIImage] = []
    
    // Variable to keep track of the current tip being shown
        var currentTipIndex: Int = 0
    
    // Action triggered when the next tip button is clicked
    @IBAction func showNextTip(_ sender: UIButton) {
        currentTipIndex += 1
        if currentTipIndex == Tips.count {
            currentTipIndex = 0
        }
        
        let Tip: String = Tips[currentTipIndex]
        TipLabel.text = Tip
        // Display the image associated with the current tip
        if currentTipIndex < picture.count {
                    pictureLabel.image = picture[currentTipIndex]
                } else {
                    print("Error: No image for index: \(currentTipIndex)")
                }
        
    }
    @IBAction func nextTipButtonWasClicked(_ sender: UIButton) {
        print("Next Tip button was clicked!")
    }


    override func viewDidLoad() {
            super.viewDidLoad()
        
        // Convert pictureNames to actual UIImage objects and store them in the picture array
        picture = pictureNames.compactMap { UIImage(named: $0) }
                
                // initial tip and image to be displayed
                TipLabel.text = Tips[currentTipIndex]
                if !picture.isEmpty {
                    pictureLabel.image = picture[0]
                }
        }
    
}
