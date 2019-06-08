//
// Copyright (c) 2018 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

//-------------------------------------------------------------------------------------------------------------------------------------------------
@objc protocol VerifySMSDelegate: class {
	func verifySMSSucceed()
	func verifySMSFailed()
}

class VerifySMSView: UIViewController {
    var phoneNumber = ""
    
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var fieldCode: UITextField!
    @IBOutlet weak var delegate: UITextFieldDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func startLogin(){
        let phoneNumber = self.phoneNumber
        let testVerificationCode = self.fieldCode.text
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        ProgressHUD.show("Loading...")
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self](verificationId, error) in
            if (error != nil){
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId ?? "", verificationCode: testVerificationCode ?? "")
            Auth.auth().signInAndRetrieveData(with: credential, completion: { [weak self](authData, error) in
                if(error != nil){
                    ProgressHUD.showError(error?.localizedDescription)
                    return
                }
                print(authData?.user)
                self?.navigationController?.dismiss(animated: true, completion: {
                    ProgressHUD.dismiss()
                    UserLoggedIn(loginMethod: LOGIN_PHONE)
                })
            })
        }
    }
}
extension VerifySMSView: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("change" + string)
        return true
    }
}
