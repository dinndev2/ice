import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ["expenses", "shadow", "expenceLine"]

  initialize() {
    this.lineFormCount = this.expenceLineTargets.length - 1
  }

  addNewLine() {
    // get the current number of lines for indexing
    const newLine = this.shadowTarget.cloneNode(true)
    const html = newLine.innerHTML.replace(/\[new\]/g, `[${this.lineFormCount}]`)
    newLine.innerHTML = html
    this.element.appendChild(newLine)
    this.lineFormCount++
  }

  removeLine(event) {
    const currentDeleteBtn = event.currentTarget;
    const parentExpenceLine = currentDeleteBtn.parentElement
    const hiddenDeleteInput = parentExpenceLine.querySelector("input[name*='_destroy']")
    if (hiddenDeleteInput) {
      hiddenDeleteInput.setAttribute("value", "true")
      parentExpenceLine.classList.add('visually-hidden')
    } else {
      parentExpenceLine.remove()
    }
  }
}
