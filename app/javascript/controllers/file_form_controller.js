import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="file-form"
export default class extends Controller {
  static targets = ["fileName"];

  realize(e) {
    if (window.File) {
      let inputfile = e.target.files[0];
      this.fileNameTarget.textContent = inputfile.name;
    }
  }
}
