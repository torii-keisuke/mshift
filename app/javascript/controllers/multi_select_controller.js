import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="multi-select"
export default class extends Controller {
  connect() {
    // console.log("おちんちん");
    this.element.textContent = "Hello World!";
  }
}
