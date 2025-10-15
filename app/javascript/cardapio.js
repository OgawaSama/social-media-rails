document.addEventListener("DOMContentLoaded", () => {
  const addItemButton = document.getElementById("add-item");
  const itensContainer = document.getElementById("itens-container");

  if (!addItemButton || !itensContainer) return;

  const template = document.getElementById("item-template");

  addItemButton.addEventListener("click", () => {
    const clone = template.content.cloneNode(true);
    itensContainer.appendChild(clone);
  });

  itensContainer.addEventListener("click", (e) => {
    if (e.target && e.target.classList.contains("remove-item")) {
      e.target.closest(".item-cardapio").remove();
    }
  });
});
