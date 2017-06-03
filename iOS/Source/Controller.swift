import UIKit
import AVFoundation

class Controller: UICollectionViewController {
    lazy var sounds: [Sound] = {
        var sounds = [Sound]()
        sounds.append(Sound(title: "👋", soundFilename: "bye", color: .lightGray))
        sounds.append(Sound(title: "🌬", soundFilename: "fart", color: .red))
        sounds.append(Sound(title: "👄", soundFilename: "female-voice", color: .green))
        sounds.append(Sound(title: "👻", soundFilename: "scream", color: .blue))
        sounds.append(Sound(title: "💋", soundFilename: "sugar-voice", color: .cyan))
        sounds.append(Sound(title: "🚽", soundFilename: "toilet", color: .yellow))
        sounds.append(Sound(title: "🚂", soundFilename: "train", color: .magenta))
        sounds.append(Sound(title: "🔫", soundFilename: "pew", color: .purple))
        sounds.append(Sound(title: "👎", soundFilename: "sad-trombone", color: .brown))
        sounds.append(Sound(title: "🥁", soundFilename: "punchline", color: .orange))

        return sounds
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 80, height: 80)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)

        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.backgroundColor = .black
        self.collectionView?.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        self.collectionView?.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
    }

    func play(sound: Sound) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)

            let url = Bundle.main.url(forResource: sound.soundFilename, withExtension: "mp3")!
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)
            player?.play()
        } catch let error as NSError {
            let controller = UIAlertController(title: NSLocalizedString("Oops, something went wrong", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .cancel, handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sounds.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        let sound = self.sounds[indexPath.row]
        cell.title = sound.title
        cell.color = sound.color

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sound = self.sounds[indexPath.row]
        self.play(sound: sound)
    }


}
