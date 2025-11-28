When("eu preencho {string} com {string}") do |field_id, content|
  fill_in_rich_text_area(field_id, with: content)
end

When("eu anexo o ficheiro {string} ao campo {string}") do |filename, field_name|
  file_path = Rails.root.join('test', 'fixtures', 'files', filename)
  attach_file(field_name, file_path)
end

When("eu clico em {string}") do |button_text|
  click_button(button_text)
end

Then("eu devo ver a mensagem {string}") do |message|
  expect(page).to have_content(message)
end

Then("eu devo ver a mensagem de erro {string}") do |error_message|
  expect(page).to have_content(error_message)
end

Then("eu não devo ver o ficheiro {string} anexado") do |filename|
  expect(page).not_to have_selector("a[href*='#{filename}']")
  expect(page).not_to have_selector("img[src*='#{filename}']")
end
