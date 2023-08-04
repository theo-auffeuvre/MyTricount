import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="params-popup"
export default class extends Controller {
  static targets = [ "popup" ]
  
  toggle(e) {
    e.preventDefault()
    this.popupTarget.classList.toggle("hidden")
  }
}
