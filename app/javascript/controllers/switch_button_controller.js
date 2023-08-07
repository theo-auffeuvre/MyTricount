import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="switch-button"
export default class extends Controller {
  static targets = [ "category", "all" ]

  toggle(e) {
    e.preventDefault()
    console.log(this.allTarget.querySelectorAll("button"))
    this.allTarget.querySelectorAll("button").forEach(element => {
      element.classList.remove("!text-white", "bg-primary")
    });
    e.currentTarget.classList.add("!text-white", "bg-primary")
    console.log(e.currentTarget.value)
    this.categoryTarget.value = e.currentTarget.value
  }
}
