document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll("[data-password]").forEach((component) => {
    component.addEventListener("change", (e) => {
      const inputElement = document.getElementById(component.getAttribute("data-password"));

      if (inputElement) {
        inputElement.type = component.checked ? "text" : "password"
        inputElement.focus()
      }
    })
  })
})
