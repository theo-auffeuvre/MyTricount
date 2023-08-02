import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = [ "tab_1", "tab_2", "content_1", "content_2" ]
  toggle(e) {
    e.preventDefault()
    e.currentTarget.classList.add('active-tab')
    this.content_1Target.classList.toggle('hidden')
    this.content_2Target.classList.toggle('hidden')
    if (e.currentTarget == this.tab_1Target) {
      this.tab_2Target.classList.remove('active-tab')
    } else {
      this.tab_1Target.classList.remove('active-tab')
    }
  }
}
