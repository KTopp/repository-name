import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = ["date"]

  connect() {
    flatpickr(this.dateTarget, {
                                  altInput: true,
                                  altFormat: "F j, Y",
                                  dateFormat: "Y-m-d",
                                  minDate: new Date().fp_incr(7)
    });
  }

}
