import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["success", "spinner"]

  connect() {
    this.modal = new bootstrap.Modal(this.element)
  }

  open() {
    if(!this.modal.isOpened) {
      this.modal.show()
    }
  }

  close(event) {
    if (event.detail.success) {
      this.successTarget.classList.remove('visually-hidden')
      this.spinnerTarget.classList.add('visually-hidden')
      setTimeout(() => {
        this.modal.hide()
      }, 1000) // wait 1.5 seconds before hiding
    }
  }
}
