document.addEventListener("turbo:load", () => {
  const container = document.getElementById("addresses-container");
  const addButton = document.getElementById("add-address");

  if (!container || !addButton) return;

  // Clonar o primeiro endereço como template
  const template = container.children[0].cloneNode(true);
  template.querySelectorAll("input").forEach(input => input.value = "");

  // Delegação: remove qualquer bloco ao clicar no botão remover
  container.addEventListener("click", e => {
    if (e.target && e.target.matches(".remove-address")) {
      e.target.closest(".business-address-fields").remove();
    }
  });

  // Adicionar novo endereço
  addButton.addEventListener("click", () => {
    const newAddress = template.cloneNode(true);
    container.appendChild(newAddress);
  });
});