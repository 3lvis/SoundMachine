import UIKit
import AVFoundation

class Controller: UICollectionViewController {
    lazy var sounds: [Sound] = {
        var sounds = [Sound]()
        sounds.append(Sound(title: "👋", soundFilename: "bye"))
        sounds.append(Sound(title: "🌬", soundFilename: "fart"))
        sounds.append(Sound(title: "👄", soundFilename: "female-voice"))
        sounds.append(Sound(title: "👻", soundFilename: "scream"))
        sounds.append(Sound(title: "💋", soundFilename: "sugar-voice"))
        sounds.append(Sound(title: "🚽", soundFilename: "toilet"))
        sounds.append(Sound(title: "🚂", soundFilename: "train"))
        sounds.append(Sound(title: "🐛", soundFilename: "crickets"))
        sounds.append(Sound(title: "🔫", soundFilename: "pew"))
        sounds.append(Sound(title: "👎", soundFilename: "sad-trombone"))

        return sounds
    }()

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 80, height: 80)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.backgroundView = UIImageView(image: UIImage(named: "background")!)
        self.collectionView?.backgroundColor = .red
        self.collectionView?.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        self.collectionView?.contentInset = UIEdgeInsets(top: 350, left: 0, bottom: 0, right: 0)
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

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sound = self.sounds[indexPath.row]
        self.play(sound: sound)
    }
}
