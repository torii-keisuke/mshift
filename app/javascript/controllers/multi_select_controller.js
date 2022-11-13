import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="multi-select"
export default class extends Controller {
  onAllCheck(e) {
    const rootCheckbox = e.target;
    const childCheckboxes =
      rootCheckbox.parentNode.parentNode.querySelectorAll("input");
    childCheckboxes.forEach((e) => {
      e.checked = rootCheckbox.checked;
    });
  }
}
