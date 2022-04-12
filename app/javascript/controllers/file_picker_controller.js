import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'filePicker', 'submitButton' ]

  manageSubmitButton(){
    const filePresent = this.hasFilePickerTarget && this.filePickerTarget.value.length > 0;

    this.submitButtonTarget.disabled = !filePresent;
  }
}
