import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search-form"
export default class extends Controller {
  static targets = ["textForm", "selectForm"];

  removeValue() {
    this.textFormTargets.forEach((text) => {
      text.value = "";
    });
    this.selectFormTargets.forEach((select) => {
      select.value = "";
    });
  }
}
