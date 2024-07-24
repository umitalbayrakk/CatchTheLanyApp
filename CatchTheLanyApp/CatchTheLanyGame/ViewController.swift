import UIKit

class ViewController: UIViewController {
    // Variables.
    var score = 0
    var timer = Timer()
    var counter = 0
    var lanyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    // Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var lany1: UIImageView!
    @IBOutlet weak var lany2: UIImageView!
    @IBOutlet weak var lany3: UIImageView!
    @IBOutlet weak var lany4: UIImageView!
    @IBOutlet weak var lany5: UIImageView!
    @IBOutlet weak var lany6: UIImageView!
    @IBOutlet weak var lany7: UIImageView!
    @IBOutlet weak var lany8: UIImageView!
    @IBOutlet weak var lany9: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        scoreLabel.text = "Score : \(score)"
        
        // HighScore Check.
        
        let stortedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if stortedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore : \(highScore)"
        }
        
        if let newScore = stortedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore : \(highScore)"
        }
        
        // Images
        lany1.isUserInteractionEnabled = true
        lany2.isUserInteractionEnabled = true
        lany3.isUserInteractionEnabled = true
        lany4.isUserInteractionEnabled = true
        lany5.isUserInteractionEnabled = true
        lany6.isUserInteractionEnabled = true
        lany7.isUserInteractionEnabled = true
        lany8.isUserInteractionEnabled = true
        lany9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        lany1.addGestureRecognizer(recognizer1)
        lany2.addGestureRecognizer(recognizer2)
        lany3.addGestureRecognizer(recognizer3)
        lany4.addGestureRecognizer(recognizer4)
        lany5.addGestureRecognizer(recognizer5)
        lany6.addGestureRecognizer(recognizer6)
        lany7.addGestureRecognizer(recognizer7)
        lany8.addGestureRecognizer(recognizer8)
        lany9.addGestureRecognizer(recognizer9)
        
        lanyArray = [lany1,lany2,lany3,lany4,lany5,lany6,lany7,lany8,lany9]
        
        // Timers.
        counter = 20
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideLany), userInfo: nil, repeats: true)
        
        hideLany()
        
    }
    
   @objc func hideLany(){
        for lany in lanyArray {
            lany.isHidden = true
        }
     let random =  Int(arc4random_uniform(UInt32(lanyArray.count - 1)))
        lanyArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
       score += 1
        scoreLabel.text = "Score : \(score)"
        
    }
    
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            // High Score.
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            // Alert.
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //Replay Func
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideLany), userInfo: nil, repeats: true)
                
               
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
        }
    }


}

