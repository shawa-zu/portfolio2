document.addEventListener("DOMContentLoaded", () => {
  const inputs = document.querySelectorAll("[data-field]");
  
  inputs.forEach(input => {
    const resultsList = input.parentElement.querySelector(".autocomplete-results");
    const field = input.dataset.field;

    input.addEventListener("input", async () => {
      const query = input.value.trim();
      if (query === "") {
        resultsList.innerHTML = "";
        resultsList.classList.add("hidden");
        return;
      }

      const response = await fetch(`/players/autocomplete?field=${field}&query=${encodeURIComponent(query)}`);
      const results = await response.json();

      resultsList.innerHTML = results
        .map(name => `<li class="px-2 py-1 hover:bg-gray-100 cursor-pointer">${name}</li>`)
        .join("");

      resultsList.classList.remove("hidden");
    });

    resultsList.addEventListener("click", (e) => {
      if (e.target.tagName === "LI") {
        input.value = e.target.textContent;
        resultsList.innerHTML = "";
        resultsList.classList.add("hidden");
      }
    });

    document.addEventListener("click", (e) => {
      if (!input.parentElement.contains(e.target)) {
        resultsList.innerHTML = "";
        resultsList.classList.add("hidden");
      }
    });
  });
});