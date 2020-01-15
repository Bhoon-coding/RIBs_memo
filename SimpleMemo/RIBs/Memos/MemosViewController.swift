import RIBs
import RxSwift
import UIKit
import RxCocoa

protocol MemosPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    var memos: BehaviorRelay<[Memo]> { get }
    func deleteMemo(_ memo: Memo)
    func changeMemo(_ memo: Memo)
    func moveToAddMemoButtonDidTap()
    func logOutButtonDidTap()
}

class MemoCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

final class MemosViewController: UIViewController, MemosPresentable {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moveToAddMemoButton: UIButton!

    weak var listener: MemosPresentableListener?
    private let disposeBag = DisposeBag()
    
    static func instantiate() -> Self {
        return Storyboard.MemosViewController.instantiate(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setNavigationBarButton()
        bindUI()
    }

    private func setNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationLargeTitleBarColor = UIColor(named: "MintColor") ?? .white
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MintColor") ?? .white
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func setNavigationBarButton() {
        let logOutBarButtonItem = UIBarButtonItem(title: "로그아웃", style: .plain, target: self, action: #selector(logOut))
        self.navigationItem.rightBarButtonItem  = logOutBarButtonItem
    }
    
    @objc func logOut() {
        listener?.logOutButtonDidTap()
    }
    
    private func bindUI() {
        moveToAddMemoButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.listener?.moveToAddMemoButtonDidTap()
        }).disposed(by: disposeBag)
        
        bindTableView()
    }
    
    private func bindTableView() {
        listener?.memos.bind(to: tableView.rx.items(cellIdentifier: "MemoCell")) { (index, memo, cell) in
            if let cell = cell as? MemoCell {
                cell.titleLabel.text = memo.title
            }
        }.disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

// MARK: UITableViewDelegate
extension MemosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let change = changeAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [change])
    }
    
    private func changeAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "수정") { [weak self] (action, view, completion) in
            guard let `self` = self, let memo = self.listener?.memos.value[indexPath.row] else { return }
            let alertController = UIAlertController(title: "메모 수정", message: nil, preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { textField in
                textField.text = memo.title
            })
            let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: { [weak self] _ in
                self?.tableView.setEditing(false, animated: true)
            })
            let saveAction = UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
                if let textField = alertController.textFields?.first, let text = textField.text {
                    if text == "" {
                        self?.listener?.deleteMemo(memo)
                    } else {
                        var newMemo = memo
                        newMemo.title = text
                        self?.listener?.changeMemo(newMemo)
                    }
                }
                self?.tableView.setEditing(false, animated: true)
            })
            alertController.addAction(cancleAction)
            alertController.addAction(saveAction)
            self.present(alertController, animated: true, completion: nil)
        }
        action.backgroundColor = .orange
        return action
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    private func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "삭제") { [weak self] (action, view, completion) in
            guard let `self` = self else { return }
            if let memo = self.listener?.memos.value[indexPath.row] {
                self.listener?.deleteMemo(memo)
            }
        }
        action.backgroundColor = .red
        return action
    }
}

// MARK: MemoViewControllable
extension MemosViewController: MemosViewControllable {
    func push(viewController: ViewControllable) {
        self.navigationController?.pushViewController(viewController.uiviewController, animated: true)
    }
}
