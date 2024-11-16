import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  onChangeState(event) {
    const url = new URL(location.href);
    const params = new URLSearchParams(location.search);
    params.set("state", event.target.value)
    url.search = params.toString();
    window.location = url.href;
  }
}
