//
// Copyright (c) 2018 Related Code -LoginPhoneView1 http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

//-------------------------------------------------------------------------------------------------------------------------------------------------
@objc protocol LoginPhoneDelegate: class {

	func didLoginPhone()
}
class LoginPhoneView: UIViewController {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var fieldPhone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nextItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextAction))
        self.navigationItem.rightBarButtonItem = nextItem
    }
    @IBAction func selectCountryAction(_ sender: Any) {
        
    }
    @objc func nextAction(){
        if fieldPhone.text?.isEmpty ?? false {
            ProgressHUD.showError("Phone number cannot be empty!")
            return
        }
        let verifySMS = VerifySMSView()
        verifySMS.phoneNumber = labelCode.text! + fieldPhone.text!
        self.navigationController?.show(verifySMS, sender: nil)
    }
}
