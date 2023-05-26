import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="client"
export default class extends Controller {
  connect() {
    console.log("connected");
  }
}
