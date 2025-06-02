import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "container"]

  connect ( ){
    console.log ("Comments controller connected")
  } ;

  toggle() {
    console.log("Toggling comments visibility");
    this.containerTarget.classList.toggle("hidden");
  // this.commentsTarget.classList.toggle("hidden");
  // this.formTarget.classList.toggle("hidden");
}
}
