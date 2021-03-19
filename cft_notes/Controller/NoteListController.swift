//
//  NoteListController.swift
//  cft_notes
//
//  Created by Zakirov Tahir on 13.03.2021.
//

import UIKit
import CoreData


class NoteListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "Cell"
    var notes = [Notes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        self.collectionView.register(NoteCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "doc.badge.plus"), style: .plain, target: self, action: #selector(createNote))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNotes()
        collectionView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }
    
    
    // открываем DetailNoteVC и создаем новую запись
    @objc fileprivate func createNote() {
        navigationController?.pushViewController(DetailNoteVC(), animated: true)
    }
    
    fileprivate func loadNotes() {
        let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            notes = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch let error as NSError {
            alertMessage(title: "Ошибка запроса из баз данных", message: error.localizedDescription)
        }
    }
    
    // переход по ячейке indexPath в DetailNoteVC, с предварительно заполенными данными
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destination = DetailNoteVC()
        destination.editNotes = notes[indexPath.item]
        navigationController?.pushViewController(destination, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NoteCell
        
        cell.titleLabel.text = notes[indexPath.item].titleNote
        cell.contentLabel.text = notes[indexPath.item].contentNote
        cell.dateLabel.text = notes[indexPath.item].dateNote
        
        return cell
    }
    
    // Выводим ошибку в UIAlertController
    fileprivate func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 80)
    }
    
    
}
