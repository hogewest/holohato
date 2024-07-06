import Dialog from '@stimulus-components/dialog'

export default class extends Dialog {
  static targets = ["form", "leastCount"]

  apply() {
    const form = this.formTarget
    const input = document.createElement("input")
    input.type = "hidden"
		input.name = "least_count"
    input.value = this.leastCountTarget.value
    form.append(input);
    form.submit();

    this.close();
  }
}
