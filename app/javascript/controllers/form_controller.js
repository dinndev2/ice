import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ["expenses", "shadow", "expenceLine", "expenceTotal", "totalInvoiceInput", "expenceParentContainer", "spinner"]
  static values = { total: Number, role: String }

  initialize() {
    if(this.roleValue == "invoice") {
      this.lineFormCount = this.expenceLineTargets.length - 1
      this.updateInvoiceTotal() 
    }
  }

  totalValueChanged() {
    if(this.roleValue == "invoice") {
      this.totalInvoiceInputTarget.value = this.totalValue
    }
  }

  showLoader(event) {
    this.spinnerTarget.classList.remove('visually-hidden');
  }

  calculateLineTotal(event) {
    const input = event.currentTarget
    const line = input.closest('[data-form-target="expenceLine"], [data-form-target="shadow"]');
    const rate = line.querySelector("input[name*='rate']")
    const quantity = line.querySelector("input[name*='quantity']")
    const total = line.querySelector("input[name*='total']")
  
    const rateVal = parseFloat(rate?.value) || 0
    const quantityVal = parseFloat(quantity?.value) || 0
  
    const calcTotal = rateVal * quantityVal
    total.value = calcTotal
    this.updateInvoiceTotal()
  }
  
  updateInvoiceTotal() {
    // gather all of expence total input value and update the totalValue 
    let total = this.expenceTotalTargets.map(input => Number(input.value)).reduce((acc, curr) => acc + curr, 0)
    this.totalValue = total
  }

  addNewLine(event) {
    // get the current number of lines for indexing
    const newLine = this.shadowTarget.cloneNode(true)
    const html = newLine.innerHTML.replace(/new/g, `${this.lineFormCount}`);
    newLine.innerHTML = html
    newLine.classList.remove('visually-hidden')
    this.expenceParentContainerTarget.appendChild(newLine)
    this.lineFormCount++
  }

  removeLine(event) {
    const currentDeleteBtn = event.currentTarget;
    const parentExpenceLine = currentDeleteBtn.parentElement
    const hiddenDeleteInput = parentExpenceLine.querySelector("input[name*='_destroy']")
    const hiddenCurrentTotalInput = parentExpenceLine.querySelector("input[name*='total']")
    if (hiddenDeleteInput) {
      hiddenDeleteInput.setAttribute("value", "true")
      parentExpenceLine.classList.add('visually-hidden')

      // on remove, reset value of current total input as it's only setting it to hidden
      // this is for existing items to pass on form at the same time we are giving the client a real time calculation
      hiddenCurrentTotalInput.setAttribute("value", 0)
      hiddenCurrentTotalInput.value = 0
    } else {
      parentExpenceLine.remove()
    }
    this.updateInvoiceTotal()
  }
}
