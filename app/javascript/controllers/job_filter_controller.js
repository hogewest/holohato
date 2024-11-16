import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  onChangeState(event) {
    const url = new URL(location.href);
    const params = new URLSearchParams(location.search);
    params.set("state", event.target.value);
    params.delete("p");
    url.search = params.toString();
    window.location = url.href;
  }
}
